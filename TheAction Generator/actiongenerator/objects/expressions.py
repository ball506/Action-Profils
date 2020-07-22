# -*- coding: utf-8 -*-
"""
Define the objects representing simc expressions.

@author: skasch
"""

import warnings
import re

from .lua import LuaExpression, LuaRange, Method, Literal, BuildExpression, LuaComparison
from .executions import Spell, Item, Potion, Variable
from .resources import (Rune, AstralPower, HolyPower, Insanity, Pain, Focus,
                        Maelstrom, Energy, ComboPoints, SoulShard,
                        ArcaneCharges, Chi, RunicPower, Fury, Rage, Mana)
from .units import Pet
from ..constants import (SPELL, BUFF, DEBUFF, BOOL, PET, BLOODLUST, MOVEMENT, DISTANCE, RANGE,
                         FALSE, MAX_INT, POTION, COOLDOWN)
from ..abstract.decoratormanager import Decorable


class ActionExpression(BuildExpression):
    """
    Represent the expression for a action. condition. Also works for expressions
    implicitly referring to the execution of the condition.
    """

    AURA_METHODS = [
        'ready',
        'remains',
        'cooldown',
        'down',
        'stack',
        'react',
        'duration',
        'tick_time',
        'ticking',
        'ticks_remain',
        'refreshable',
        'pmultiplier',
    ]

    def __init__(self, condition, to_self=False):
        for method_name in self.AURA_METHODS:
            self._generate_aura_method(method_name)
        self.condition = condition
        self.to_self = to_self
        if to_self:
            call = condition.condition_list[0]
        else:
            call = condition.condition_list[2]
        self.object_ = self._action_object()
        self.method = None
        self.args = []
        self.range_ = None
        self.aura_model = self._build_aura()
        super().__init__(call)

    def _action_object(self):
        """
        The object of the action expression, depending on whether the action is
        applied to self (i.e. the execution) or not.
        """
        if self.to_self:
            return self.condition.parent_action.execution().object_()
        if self.condition.condition_list[1] == POTION:
            return Potion(self.condition.parent_action)
        return Spell(self.condition.parent_action,
                     self.condition.condition_list[1])

    def _build_aura(self):
        """
        The action aura when referring to the action as a buff or debuff.
        """
        action_object = self._action_object()
        if self.condition.player_unit.spell_property(action_object, DEBUFF):
            aura_type = DEBUFF
            aura_object = Literal('Unit(unit)')
        elif self.condition.player_unit.spell_property(action_object, BUFF):
            aura_type = BUFF
            aura_object = Literal('Unit("player")')
        else:
            return None
        aura_action = Spell(self.condition.parent_action,
                            action_object.simc, type_=aura_type)
        aura = Aura(self.condition, aura_type, aura_object, spell=aura_action)
        return aura

    def _from_aura(self):
        """
        Get attributes from the aura corresponding to the action object.
        """
        self.object_ = self.aura_model.object_
        self.method = self.aura_model.method
        self.args = self.aura_model.args

    def _generate_aura_method(self, name):
        def method(self):
            getattr(self.aura_model, name)()
            self._from_aura()

        setattr(self, name, method.__get__(self, self.__class__))

    def execute_time(self):
        """
        Return the arguments for the expression action.spell.execute_time.
        """
        self.method = Method('GetSpellCastTime()')

    def recharge_time(self):
        """
        Return the arguments for the expression action.spell.recharge_time.
        """
        self.method = Method('RechargeP()')

    def full_recharge_time(self):
        """
        Return the arguments for the expression action.spell.full_recharge_time.
        """
        self.method = Method('GetSpellChargesFullRechargeTime()')

    def cast_time(self):
        """
        Return the arguments for the expression action.spell.cast_time.
        """
        self.method = Method('GetSpellCastTime()')

    def charges(self):
        """
        Return the arguments for the expression action.spell.charges.
        """
        self.method = Method('GetSpellCharges()')

    def charges_fractional(self):
        """
        Return the arguments for the expression action.spell.charges.
        """
        self.method = Method('GetSpellChargesFrac()')

    def cooldown(self):
        """
        Return the arguments for the expression action.spell.charges.
        """
        self.method = Method('GetCooldown()', type_=BOOL)

    def usable_in(self):
        """
        Return the arguments for the expression action.spell.usable_in.
        """
        self.method = Method('UsableInP()')

    def travel_time(self):
        """
        Return the arguments for the expression action.spell.travel_time.
        """
        self.method = Method('TravelTime()')

    def cooldown_react(self):
        """
        Return the arguments for the expression action.spell.cooldown_react.
        """
        self.method = Method('GetCooldown() == 0', type_=BOOL)

    def in_flight(self):
        """
        Return the arguments for the expression action.spell.in_flight.
        """
        self.method = Method('IsSpellInFlight()', type_=BOOL)
        self.object_.action.context.add_inflight(self.object_)

    def max_charges(self):
        """
        Return the arguments for the expression action.spell.max_charges.
        """
        self.method = Method('GetSpellChargesMax()')

    def cost(self):
        """
        Return the arguments for the expression action.spell.cost.
        """
        self.method = Method('GetSpellPowerCostCache()')

    def spell_targets(self):
        """
        Return the arguments for the expression action.spell.spell_targets.
        """
        self.range_ = self.condition.player_unit.spell_property(
            self._action_object(), RANGE,
            self.condition.player_unit.spec_range())
        self.model = LuaRange

    def cast_regen(self):
        """
        Return the arguments for the expression action.spell.cast_regen.
        """
        self.object_ = self.condition.player_unit
        self.method = Method('FocusCastRegen')
        self.args = [LuaExpression(self._action_object(),
                                   Method('GetSpellCastTime'),
                                   [])]

    def active_enemies(self):
        """
        Return the arguments for the expression action.spell.active_enemies.
        """
        self.spell_targets()

    def time_to_die(self):
        """
        Return the arguments for the expression time_to_die.
        """
        self.object_ = Literal('Unit(unit)')
        self.method = Method('TimeToDie()')

    def usable(self):
        """
        Return the arguments for the expression action.spell.usable.
        """
        self.method = self.object_.condition_method
        self.args = self.object_.condition_args


class Expression(Decorable):
    """
    Represent a singleton condition (i.e. without any operator).
    """

    actions_to_self = (ActionExpression.AURA_METHODS
                       + [method for method in dir(ActionExpression)
                          if callable(getattr(ActionExpression, method))
                          and not method.startswith('_')
                          and not method == 'print_lua'])

    def __init__(self, condition_expression, simc):
        self.condition_expression = condition_expression
        self.parent_action = condition_expression.action
        self.simc = simc
        self.pet_caster = None
        self.condition_list = self.build_condition_list()
        self.player_unit = condition_expression.action.player
        self.target_unit = condition_expression.action.target

    def build_condition_list(self):
        """
        Return the splitted structure of the condition.
        """
        return self.simc.split('.')

    def expression(self):
        """
        Return the expression of the condition.
        """
        try:
            """
			DK Gargoyle
            """
            if self.simc == 'pet.gargoyle.active':
                return Literal('Pet:IsActive(A.Gargoyle.ID)')
            """
			DK Gargoyle
            """
            if self.simc == 'pet.apoc_ghoul.active':
                return Literal('Pet:IsActive(A.ApocGhoul.ID)')
            """
			WL Demonology
            """
            if self.simc == 'pet.demonic_tyrant.active':
                return Literal('Pet:IsActive(A.DemonicTyrant.ID)')	
				
            if (self.condition_list[0] in self.actions_to_self
                    and len(self.condition_list) == 1):
                return self.action(to_self=True)
            return getattr(self, self.condition_list[0])()
        except AttributeError:
            try:
                float(self.simc)
            except ValueError:
                if self.simc not in '':
                    warnings.warn(
                        f'Failed to parse the expression {self.simc} in {self.player_unit.apl.profile_name} (line {self.parent_action.simc})')
            return Literal(self.simc)

    def caster(self, spell=None):
        """
        The caster of the spell; default is player, is pet if the spell is cast
        by a pet.
        """
        if self.player_unit.spell_property(spell, PET):
            return Pet(self.player_unit)
        if self.pet_caster:
            return self.pet_caster
        return self.player_unit
    
    def pet(self):
        """
        Return the condition for a pet.{name}.{condition} expression.
        """
        pet_name = self.condition_list[1]
        condition_name = self.condition_list[2]
        self.pet_caster = Pet(self.player_unit, pet_name)
        self.condition_list = self.condition_list[2:]
        return self.expression()

    def action(self, to_self=False):
        """
        Return the condition when the prefix is action.
        """
        return ActionExpression.build(self, to_self)

    def spell_haste(self):
        """
        Return the condition when the prefix is spell_haste.
        """
        return Literal('Player:SpellHaste()')

    def set_bonus(self):
        """
        Return the condition when the prefix is set_bonus.
        """
        return SetBonus.build(self)

    def equipped(self):
        """
        Return the condition when the prefix is equipped.
        """
        return Equipped.build(self)

    def cooldown(self):
        """
        Return the condition when the prefix is cooldown.
        """
        return Cooldown.build(self)
		
    def essence(self):
        """
        Return the condition when the prefix is essence.
        """
        return Essence.build(self)

    def consumable(self):
        """
        Return the condition when the prefix is consumable.
        """
        return Consumable.build(self)

    def buff(self):
        """
        Return the condition when the prefix is buff.
        """
        return Buff.build(self)

    def debuff(self):
        """
        Return the condition when the prefix is debuff.
        """
        return DeBuff.build(self)

    def dot(self):
        """
        Return the condition when the prefix is dot.
        """
        return Dot.build(self)

    def active_dot(self):
        """
        Return the condition when the prefix is active_dot.
        """
        return ActiveDot.build(self)

    def prev_gcd(self):
        """
        Return the condition when the prefix is prev_gcd.
        """
        return PrevGCD.build(self)

    def prev_off_gcd(self):
        """
        Return the condition when the prefix is prev_off_gcd.
        """
        return PrevOffGCD.build(self)

    def persistent_multiplier(self):
        """
        Return the condition when the prefix is persistent_multiplier.
        """
        return PMultiplier.build(self)

    def desired_targets(self):
        """
        Return the condition when the prefix is desired_targets.
        """
        self.simc = 1
        return Literal(self.simc)

    def gcd(self):
        """
        Return the condition when the prefix is gcd.
        """
        return GCD.build(self)

    def time(self):
        """
        Return the condition when the prefix is time.
        """
        return Time.build(self)

    def rune(self):
        """
        Return the condition when the prefix is rune.
        """
        return Rune.build(self)

    def astral_power(self):
        """
        Return the condition when the prefix is astral_power.
        """
        return AstralPower.build(self)

    def holy_power(self):
        """
        Return the condition when the prefix is holy_power.
        """
        return HolyPower.build(self)

    def insanity(self):
        """
        Return the condition when the prefix is insanity.
        """
        return Insanity.build(self)

    def pain(self):
        """
        Return the condition when the prefix is pain.
        """
        return Pain.build(self)

    def focus(self):
        """
        Return the condition when the prefix is focus.
        """
        return Focus.build(self)

    def maelstrom(self):
        """
        Return the condition when the prefix is maelstrom.
        """
        return Maelstrom.build(self)

    def energy(self):
        """
        Return the condition when the prefix is energy.
        """
        return Energy.build(self)

    def combo_points(self):
        """
        Return the condition when the prefix is combo_points.
        """
        return ComboPoints.build(self)

    def soul_shard(self):
        """
        Return the condition when the prefix is soul_shard.
        """
        return SoulShard.build(self)

    def arcane_charges(self):
        """
        Return the condition when the prefix is arcane_charges.
        """
        return ArcaneCharges.build(self)

    def chi(self):
        """
        Return the condition when the prefix is chi.
        """
        return Chi.build(self)

    def runic_power(self):
        """
        Return the condition when the prefix is runic_power.
        """
        return RunicPower.build(self)

    def fury(self):
        """
        Return the condition when the prefix is fury.
        """
        return Fury.build(self)

    def rage(self):
        """
        Return the condition when the prefix is rage.
        """
        return Rage.build(self)

    def mana(self):
        """
        Return the condition when the prefix is mana.
        """
        return Mana.build(self)

    def artifact(self):
        """
        Return the condition when the prefix is artifact.
        """
        return Artifact.build(self)

    def azerite(self):
        """
        Return the condition when the prefix is azerite.
        """
        return Azerite.build(self)

    def talent(self):
        """
        Return the condition when the prefix is talent.
        """
        return Talent.build(self)

    def movement(self):
        """
        Return the condition when the prefix is movement.
        """
        return Movement.build(self)

    def race(self):
        """
        Return the condition when the prefix is race.
        """
        return Race.build(self)

    def spell_targets(self):
        """
        Return the condition when the prefix is spell_targets.
        """
        return SpellTargets.build(self)

    def level(self):
        """
        Return the condition when the prefix is level.
        """
        return LuaExpression(self.player_unit, Method('level'))

    def target(self):
        """
        Return the condition when the prefix is target.
        """
        if len(self.condition_list) <= 1:
            return Literal('Unit(unit)')
        return TargetExpression.build(self)

    def raid_event(self):
        """
        Return the condition when the prefix is target.
        """
        return RaidEvent.build(self)

    def variable(self):
        """
        Return the condition when the prefix is variable.
        """
        return Variable(self.parent_action, self.condition_list[1])


class Expires:
    """
    Available expressions for conditions with expiration times.
    """

    def __init__(self, condition, simc, ready_simc, spell_type=SPELL,
                 spell=None):
        self.condition = condition
        self.simc = Literal(simc, convert=True)
        self.ready_simc = Literal(ready_simc, convert=True)
        if not spell:
            spell_simc = condition.condition_list[1]
            if spell_simc == BLOODLUST:
                self.spell = Literal(BLOODLUST)
            elif spell_simc == MOVEMENT:
                self.spell = Literal(MOVEMENT)
            elif spell_simc == COOLDOWN:
                self.spell = Literal(COOLDOWN)
            elif spell_simc == POTION:
                self.spell = Spell(condition.parent_action,
                                   condition.player_unit.potion(), spell_type)
            else:
                self.spell = Spell(condition.parent_action, spell_simc,
                                   spell_type)
        else:
            self.spell = spell
        self.object_ = self.spell
        self.method = None
        self.args = []

    def ready(self):
        """
        Return the arguments for the expression {expires}.spell.up.
        """
        if self.spell.simc == BLOODLUST:
            self.method = Method('HasHeroism', type_=BOOL)
            # Required when called from Aura
            self.args = []
        elif self.spell.simc == MOVEMENT:
            self.method = Method('IsMoving', type_=BOOL)
            # Required when called from Aura
            self.args = []
        else:
            fullstring = f'Has{self.ready_simc.print_lua()}s'
            substring = "CooldownUp"
            if re.search(substring, fullstring):
                self.method = Method(f'GetCooldown() == 0', type_=BOOL)
            else:
                self.method = Method(f'Has{self.ready_simc.print_lua()}s', type_=BOOL)

    def remains(self):
        """
        Return the arguments for the expression {expires}.spell.remains.
        """
        if self.spell.simc == BLOODLUST:
            self.method = Method('HasHeroism', type_=BOOL)
            # Required when called from Aura
            self.args = []
        else:
            fullstring = (f'Has{self.simc.print_lua()}s')
            substring = "HasCooldowns"
            if re.search(substring, fullstring):
                self.method = Method(f'Get{self.simc.print_lua()}()')
            else:
                self.method = Method(f'Has{self.simc.print_lua()}s')

    def duration(self):
        """
        Return the arguments for the expression {aura}.spell.duration.
        """
        self.method = Method('BaseDuration()')

class Aura(Expires):
    """
    Available expressions for auras (buffs and debuffs).
    """

    def __init__(self, condition, simc, object_, spell_type=SPELL, spell=None):
        super().__init__(condition, simc, simc, spell_type=spell_type,
                         spell=spell)
        # Overrides values from Expires
        self.object_ = object_
        self.method = None
        self.args = [self.spell]

    def down(self):
        """
        Return the arguments for the expression {aura}.spell.down.
        """
        if self.spell.simc == BLOODLUST:
            self.method = Method('HasNotHeroism', type_=BOOL)
            self.args = []
        else:
            self.method = Method(f'Has{self.simc.lua_name()}sDown')
            """self.method = Method(f'Has{self.simc.lua_name()}(A.{self.spell.lua_name()}.ID, true) == 0')"""
    def stack(self):
        """
        Return the arguments for the expression {aura}.spell.stack.
        """
        if self.spell.simc == BLOODLUST:
            self.method = Method('HasHeroism()', type_=BOOL)
            self.args = []
        else:
            self.method = Method(f'Has{self.simc.print_lua()}sStacks')

    def refreshable(self):
        """
        Return the arguments for the expression {aura}.spell.refreshable.
        """
        self.method = Method(f'Has{self.simc.lua_name()}sRefreshable', type_=BOOL)

    def react(self):
        """
        Return the arguments for the expression {aura}.spell.stack.
        """
        self.stack()

    def duration(self):
        """
        Return the arguments for the expression {aura}.spell.duration.
        """
        # Override as buff.spell.duration refers to the Expires form.
        self.object_ = self.spell
        self.method = Method('BaseDuration()')
        self.args = []

    def tick_time(self):
        """
        Return the arguments for the expression {aura}.spell.tick_time.
        """
        self.object_ = self.spell
        self.method = Method('TickTime()')
        self.args = []

    def ticking(self):
        """
        Return the arguments for the expression {aura}.spell.ticking.
        """
        self.ready()

    def ticks_remain(self):
        """
        Return the arguments for the expression {aura}.spell.ticks_remain.
        """
        self.method = Method(f'{self.simc.lua_name()}TicksRemainP')

    def pmultiplier(self):
        """
        Return the arguments for the expression {aura}.spell.pmultiplier.
        """
        self.object_ = []
        self.method = Method(f'A.PMultiplier(unit, A.{self.spell.lua_name()}.ID)')
        #self.method = Method('PMultiplier')
        self.args = []


class SetBonus(BuildExpression):
    """
    Represent the expression for a set_bonus. condition.
    """

    def __init__(self, condition):
        self.condition = condition
        self.simc = None
        self.type_ = BOOL
        super().__init__('lua_tier_name', model=Literal)

    def lua_tier_name(self):
        """
        Parse the lua name for the tier variable name holding whether a tier set
        is equipped or not.
        """
        simc = self.condition.condition_list[1]
        self.simc = f'HL.{"_".join(word.title() for word in simc.split("_"))}'


class Equipped(BuildExpression):
    """
    Represent the expression for a equipped. condition.
    """

    def __init__(self, condition):
        self.condition = condition
        call = 'value'
        self.object_ = Item(condition.parent_action,
                            condition.condition_list[1])
        self.method = None
        self.args = []
        super().__init__(call)

    def value(self):
        """
        Return the arguments for the expression equipped.
        """
        self.method = Method('IsExists()', type_=BOOL)

class PrevGCD(BuildExpression):
    """
    Represent the expression for a prev_gcd. condition.
    """

    def __init__(self, condition):
        self.condition = condition
        call = 'value'
        self.object_ = Literal('Player')
        self.method = None
        self.args = [Literal(condition.condition_list[1]),
                     Spell(condition.parent_action,
                           condition.condition_list[2])]
        super().__init__(call)

    def value(self):
        """
        Return the arguments for the expression prev_gcd.
        """
        self.method = Method('PrevGCD', type_=BOOL)

class ActiveDot(BuildExpression):
    """
    Represent the expression for a active_dot. condition.
    """

    def __init__(self, condition):
        self.condition = condition
        call = 'value'
        self.object_ = Spell(condition.parent_action, condition.condition_list[1], type_=DEBUFF)
        self.method = None
        self.args = []
        super().__init__(call)

    def value(self):
        """
        Return the arguments for the expression active_dot.
        """
        self.method = Method('ActiveDot')


class PrevOffGCD(BuildExpression):
    """
    Represent the expression for a prev_off_gcd. condition.
    """

    def __init__(self, condition):
        self.condition = condition
        call = 'value'
        self.object_ = condition.caster(condition.condition_list[1])
        self.method = None
        self.args = [Literal(1), Spell(condition.parent_action,
                                       condition.condition_list[1])]
        super().__init__(call)

    def value(self):
        """
        Return the arguments for the expression prev_off_gcd.
        """
        self.method = Method('PrevOffGCDP', type_=BOOL)


class GCD(BuildExpression):
    """
    Represent the expression for a gcd. condition.
    """

    # TODO update GCD to take into account current execution.

    def __init__(self, condition):
        self.condition = condition
        if len(condition.condition_list) > 1:
            call = condition.condition_list[1]
        else:
            call = 'value'
        self.object_ = None
        self.method = None
        self.args = []
        super().__init__(call)

    def remains(self):
        """
        Return the arguments for the expression gcd.remains.
        """
        self.method = Method('GetCurrentGCD()')

    def max(self):
        """
        Return the arguments for the expression gcd.max.
        """
        return self.value()

    def value(self):
        """
        Return the arguments for the expression gcd.
        """
        self.method = Method('GetGCD()')


class PMultiplier(BuildExpression):
    """
    Represent the expression for a persistent_multiplier condition.
    """

    def __init__(self, condition):
        self.condition = condition
        call = 'value'
        self.object_ = condition.player_unit
        self.method = None
        self.args = [condition.parent_action.execution().object_()]
        super().__init__(call)

    def value(self):
        """
        Return the arguments for the expression persistent_multiplier
        """
        self.object_ = []
        self.method = Method('A.Persistent_PMultiplier')



class Time(BuildExpression):
    """
    Represent the expression for a time. condition.
    """

    def __init__(self, condition):
        self.condition = condition
        if len(condition.condition_list) > 1:
            call = condition.condition_list[1]
        else:
            call = 'value'
        self.object_ = None
        self.method = None
        self.args = []
        super().__init__(call)

    def value(self):
        """
        Return the arguments for the expression time.
        """
        self.method = Method('Unit("player"):CombatTime()')


class Artifact(BuildExpression):
    """
    Represent the expression for an artifact. condition.
    """

    def __init__(self, condition):
        self.condition = condition
        call = condition.condition_list[2]
        self.object_ = Spell(condition.parent_action,
                             condition.condition_list[1])
        self.method = None
        self.args = []
        super().__init__(call)

    def rank(self):
        """
        Return the arguments for the expression artifact.spell.rank.
        """
        self.method = Method('ArtifactRank')

    def enabled(self):
        """
        Return the arguments for the expression artifact.spell.enabled.
        """
        self.method = Method('ArtifactEnabled', type_=BOOL)


class Azerite(BuildExpression):
    """
    Represent the expression for an Azerite. condition.
    """

    def __init__(self, condition):
        self.condition = condition
        call = condition.condition_list[2]
        self.object_ = Spell(condition.parent_action,
                             condition.condition_list[1])
        self.method = None
        self.args = []
        super().__init__(call)

    def rank(self):
        """
        Return the arguments for the expression azerite.spell.rank.
        """
        self.method = Method('GetAzeriteRank()')

    def enabled(self):
        """
        Return the arguments for the expression azerite.spell.enabled.
        """
        self.method = Method('GetAzeriteRank() > 0')


class Talent(BuildExpression):
    """
    Represent the expression for a talent. condition.
    """

    def __init__(self, condition):
        self.condition = condition
        call = condition.condition_list[2]
        self.object_ = Spell(condition.parent_action,
                             condition.condition_list[1])
        self.method = None
        self.args = []
        super().__init__(call)

    def enabled(self):
        """
        Return the arguments for the expression talent.spell.enabled.
        """
        self.method = Method('IsSpellLearned()', type_=BOOL)

class Movement(BuildExpression):
    """
    Represent the expression for a talent. condition.
    """

    def __init__(self, condition):
        self.condition = condition
        call = condition.condition_list[1]
        self.object_ = Literal('Unit(unit)')
        self.method = None
        self.args = []
        super().__init__(call)

    def distance(self):
        """
        Return the arguments for the expression talent.spell.enabled.
        """
        self.method = Literal('GetRange()')


class Race(BuildExpression):
    """
    Represent the expression for a race. condition.
    """

    def __init__(self, condition):
        self.condition = condition
        self.object_ = condition.player_unit
        self.method = Method('IsRace', type_=BOOL)
        self.args = [Literal(condition.condition_list[1], convert=True,
                             quoted=True)]
        super().__init__('')


class SpellTargets(BuildExpression):
    """
    Represent the expression for a spell_targets. condition.
    """

    def __init__(self, condition):
        self.condition = condition
        self.range_ = condition.player_unit.spell_property(
            condition.condition_list[1], RANGE, 5)
        super().__init__(None, model=LuaRange)


class DeBuff(BuildExpression, Aura):
    """
    Represent the expression for a debuff. condition.
    """

    def __init__(self, condition):
        object_ = condition.target_unit
        Aura.__init__(self, condition, DEBUFF, object_, spell_type=DEBUFF)
        call = condition.condition_list[2]
        super().__init__(call)

class Dot(DeBuff):
    """
    Represent the expression for a dot. condition.
    """

class Consumable(BuildExpression):
    """
    Represent the expression for a consumable. condition.
    """

    def __init__(self, condition):
        self.object_ = Literal('Unit(unit)')
        self.method = None
        self.args = [Spell(condition.parent_action,
                           condition.condition_list[1],
                           type_=BUFF)]
        if len(condition.condition_list) > 2:
            call = condition.condition_list[2]
        else:
            call = 'ready'
        super().__init__(call)

    def ready(self):
        """
        Return the arguments for the expression consumable.item(.ready).
        """
        self.method = Method('HasBuffs', type_=BOOL)


class Buff(BuildExpression, Aura):
    """
    Represent the expression for a buff. condition.
    """

    def __init__(self, condition):
        object_ = condition.caster()
        Aura.__init__(self, condition, BUFF, object_, spell_type=BUFF)
        call = condition.condition_list[2]
        super().__init__(call)

class Cooldown(BuildExpression, Expires):
    """
    Represent the expression for a cooldown. condition.
    """

    def __init__(self, condition):
        Expires.__init__(self, condition, 'cooldown', 'cooldown_up')
        call = condition.condition_list[2]
        super().__init__(call)

    def charges(self):
        """
        Return the arguments for the expression cooldown.spell.charges.
        """
        self.method = Method('GetSpellCharges()')

    def recharge_time(self):
        """
        Return the arguments for the expression cooldown.spell.recharge_time.
        """
        self.method = Method('RechargeP()')

    def full_recharge_time(self):
        """
        Return the arguments for the expression
        cooldown.spell.full_recharge_time.
        """
        self.method = Method('FullRechargeTimeP()')

    def charges_fractional(self):
        """
        Return the arguments for the expression
        cooldown.spell.charges_fractional.
        """
        self.method = Method('GetSpellChargesFrac()')
		

class Essence(BuildExpression):
    """
    Represent the expression for a essence. condition.
    """

    def __init__(self, condition):
        Expires.__init__(self, condition, 'cooldown', 'cooldown_up')
        call = condition.condition_list[2]
        super().__init__(call)
    
    def enabled(self):
        """
        Return the arguments for the expression essence.spell.enabled.
        """
        self.method = Method('IsSpellLearned()')
    
    def minor(self):
        """
        Return the arguments for the expression essence.spell.major.
        """
        self.object_ = Literal('Azerite')
        self.method = Method(f'EssenceHasMinor(A.{self.spell.lua_name()}.ID)')

    def major(self):
        """
        Return the arguments for the expression essence.spell.major.
        """
        self.object_ = Literal('Azerite')
        self.method = Method(f'EssenceHasMajor(A.{self.spell.lua_name()}.ID)')

    def rank(self):
        """
        Return the arguments for the expression essence.spell.rank.
        """
        self.method = Method('GetAzeriteRank()')

class RaidEvent(BuildExpression):
    """
    Represent the expression for a raid_event condition.
    """

    def __init__(self, condition):
        self.condition = condition
        self.simc = None
        call = '_'.join(condition.condition_list[1:])
        super().__init__(call, model=Literal)

    def adds_in(self):
        """
        Return the argument for the expressions raid_event.adds.in.
        """
        self.simc = MAX_INT

    def adds_exists(self):
        """
        Return the argument for the expressions raid_event.adds.exists.
        """
        self.range_ = self.condition.player_unit.spell_property(
            self.condition.parent_action.execution().object_(), RANGE,
            self.condition.player_unit.spec_range())
        self.type_ = BOOL
        self.simc = LuaComparison(LuaRange(self.condition, self.range_), Literal(1), '>').print_lua()

    def adds_up(self):
        """
        Return the argument for the expressions raid_event.adds.up.
        """
        self.range_ = self.condition.player_unit.spell_property(
            self.condition.parent_action.execution().object_(), RANGE,
            self.condition.player_unit.spec_range())
        self.type_ = BOOL
        self.simc = LuaComparison(LuaRange(self.condition, self.range_), Literal(1), '>').print_lua()

    def adds_remains(self):
        """
        Return the argument for the expressions raid_event.adds.remains.
        """
        self.simc = 0

    def adds_count(self):
        """
        Return the argument for the expressions raid_event.adds.count.
        """
        self.range_ = self.condition.player_unit.spell_property(
            self.condition.parent_action.execution().object_(), RANGE,
            self.condition.player_unit.spec_range())
        self.simc = '(' + LuaRange(self.condition, self.range_).print_lua() + ' - 1)'

    def movement_in(self):
        """
        Return the argument for the expressions raid_event.movement.in.
        """
        self.simc = MAX_INT

    def movement_exists(self):
        """
        Return the argument for the expressions raid_event.movement.exists.
        """
        self.simc = FALSE


class TargetExpression(BuildExpression):
    """
    Represent the expression for a target. condition.
    """

    def __init__(self, condition):
        self.condition = condition
        call = condition.condition_list[1]
        self.object_ = self.condition.target_unit
        self.method = None
        self.args = []
        super().__init__(call)

    def time_to_die(self):
        """
        Return the arguments for the expression target.time_to_die.
        """
        self.method = Method('TimeToDie()')

    def time_to_pct_30(self):
        """
        Return the arguments for the expression target.time_to_pct_30.
		Trick for execution checks
        """
        self.method = Method('TimeToDieX(30)')

    def health(self):
        """
        Return the argument for the expressions target.health.{something}.
        """
        if self.condition.condition_list[2] == 'pct':
            self.method = Method('HealthPercent()')

    def debuff(self):
        """
        Return the argument for the expressons target.debuff.{something}.
        """
        if self.condition.condition_list[2] == 'casting':
            self.method = Method('IsCasting', type_=BOOL)
        if self.condition.condition_list[3] == 'remains':
            self.method = Method('HasDeBuffs')
            self.args = [Spell(self.condition.parent_action,
                               self.condition.condition_list[2])]
