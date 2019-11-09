# -*- coding: utf-8 -*-
"""
Context of an APL.

@author: skasch
"""

from ..abstract.decoratormanager import Decorable
from ..constants import PET
from ..database import ITEM_INFO


class Context(Decorable):
    """
    Defines the context of an APL, used to print everything outside the Apl
    main function.
    """

    HEADER = (
        '--- ====================== ACTION HEADER ============================ ---\n'		
        'local Action                                 = Action\n'
        'local TeamCache                              = Action.TeamCache\n'
        'local EnemyTeam                              = Action.EnemyTeam\n'
        'local FriendlyTeam                           = Action.FriendlyTeam\n'
        '--local HealingEngine                        = Action.HealingEngine\n'
        'local LoC                                    = Action.LossOfControl\n'
        'local Player                                 = Action.Player\n'
        'local MultiUnits                             = Action.MultiUnits\n'
        'local UnitCooldown                           = Action.UnitCooldown\n'
        'local Unit                                   = Action.Unit\n' 
        'local Pet                                    = LibStub("PetLibrary")\n'
        'local Azerite                                = LibStub("AzeriteTraits")\n'
        'local setmetatable                           = setmetatable\n')

    CONTENT_HEADER = (
        '--- ============================ CONTENT ===========================\n'
        '--- ======= APL LOCALS =======\n'
        '-- luacheck: max_line_length 9999\n')

    NUM_FUNCTION = (
        'local function num(val)\n'
        '    if val then return 1 else return 0 end\n'
        'end\n')

    BOOL_FUNCTION = (
        'local function bool(val)\n'
        '    return val ~= 0\n'
        'end\n')

    def __init__(self):
        self.spells = {}
        self.items = {}
        self.variables = {}
        self.inflight = {}
        self.ranges = []
        self.custom_code = [self.NUM_FUNCTION, self.BOOL_FUNCTION]
        self.player = None

    def add_spell(self, spell):
        """
        Add a spell to the context.
        """
        if (spell.simc, spell.type_) not in self.spells:
            self.spells[(spell.simc, spell.type_)] = spell

    def add_item(self, item):
        """
        Add an item to the context.
        """
        if item.simc not in self.items:
            self.items[item.simc] = item

    def add_variable(self, variable):
        """
        Add an variable to the context.
        """
        if variable.simc not in self.variables:
            self.variables[variable.simc] = variable

    def add_inflight(self, spell):
        """
        Add an inflight registration to the context.
        """
        if spell.simc not in self.inflight:
            self.inflight[spell.simc] = spell

    def add_range(self, range_):
        """
        Add an range to the context.
        """
        if range_ not in self.ranges:
            self.ranges.append(range_)

    def set_player(self, player):
        """
        Set the player for the context.
        """
        self.player = player

    def add_code(self, code):
        """
        Add custom code to the context.
        """
        self.custom_code.append(code)

    def print_spells(self):
        """
        Print the spells object in lua context.
        """
        class_ = self.player.class_.lua_name().upper()
        spec = self.player.spec.lua_name().upper()
        lua_spells = (
            '-- Spells\n'
            f'Action[ACTION_CONST_{class_}_{spec}] = '
            '{\n'
            )
        for i, spell in enumerate(self.spells.values()):
            spell_id = str(self.player.spell_property(spell, spell.type_, ''))
            pet_str = ''
            if self.player.spell_property(spell, PET):
                pet_str = f', "{PET}"'
            lua_spells += (f'    {spell.lua_name():38} = '
            'Action.Create('
            '{Type = "Spell", '
            f'ID = {spell_id}{pet_str}'
            ' })')
            lua_spells += ',\n' if i < len(self.spells) - 1 else '\n'
        lua_spells += (
            '    -- Trinkets\n'
            '    TrinketTest                            = Action.Create({ Type = "Trinket", ID = 122530, QueueForbidden = true }), \n'
            '    TrinketTest2                           = Action.Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }), \n'  
            '    AzsharasFontofPower                    = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }), \n'
            '    PocketsizedComputationDevice           = Action.Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }), \n'
            '    RotcrustedVoodooDoll                   = Action.Create({ Type = "Trinket", ID = 159624, QueueForbidden = true }), \n'
            '    ShiverVenomRelic                       = Action.Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }), \n'
            '    AquipotentNautilus                     = Action.Create({ Type = "Trinket", ID = 169305, QueueForbidden = true }), \n'
            '    TidestormCodex                         = Action.Create({ Type = "Trinket", ID = 165576, QueueForbidden = true }), \n'
            '    VialofStorms                           = Action.Create({ Type = "Trinket", ID = 158224, QueueForbidden = true }), \n'
            '    -- Potions\n'
            '    PotionofUnbridledFury                  = Action.Create({ Type = "Potion", ID = 169299, QueueForbidden = true }), \n' 
            '    PotionTest                             = Action.Create({ Type = "Potion", ID = 142117, QueueForbidden = true }), \n'
            '    -- Trinkets\n'
            '    GenericTrinket1                        = Action.Create({ Type = "Trinket", ID = 114616, QueueForbidden = true }),\n'
            '    GenericTrinket2                        = Action.Create({ Type = "Trinket", ID = 114081, QueueForbidden = true }),\n'
            '    TrinketTest                            = Action.Create({ Type = "Trinket", ID = 122530, QueueForbidden = true }),\n'
            '    TrinketTest2                           = Action.Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }), \n'
            '    AzsharasFontofPower                    = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),\n'
            '    PocketsizedComputationDevice           = Action.Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }),\n'
            '    RotcrustedVoodooDoll                   = Action.Create({ Type = "Trinket", ID = 159624, QueueForbidden = true }),\n'
            '    ShiverVenomRelic                       = Action.Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }),\n'
            '    AquipotentNautilus                     = Action.Create({ Type = "Trinket", ID = 169305, QueueForbidden = true }),\n'
            '    TidestormCodex                         = Action.Create({ Type = "Trinket", ID = 165576, QueueForbidden = true }),\n'
            '    VialofStorms                           = Action.Create({ Type = "Trinket", ID = 158224, QueueForbidden = true }),\n'
            '    GalecallersBoon                        = Action.Create({ Type = "Trinket", ID = 159614, QueueForbidden = true }),\n'
            '    InvocationOfYulon                      = Action.Create({ Type = "Trinket", ID = 165568, QueueForbidden = true }),\n'
            '    LustrousGoldenPlumage                  = Action.Create({ Type = "Trinket", ID = 159617, QueueForbidden = true }),\n'
            '    ComputationDevice                      = Action.Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }),\n'
            '    VigorTrinket                           = Action.Create({ Type = "Trinket", ID = 165572, QueueForbidden = true }),\n'
            '    FontOfPower                            = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),\n'
            '    RazorCoral                             = Action.Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),\n'
            '    AshvanesRazorCoral                     = Action.Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),\n'
            '    -- Misc\n'
            '    Channeling                           = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),	-- Show an icon during channeling\n'
            '    TargetEnemy                          = Action.Create({ Type = "Spell", ID = 44603, Hidden = true     }),	-- Change Target (Tab button)\n'
            '    StopCast 				             = Action.Create({ Type = "Spell", ID = 61721, Hidden = true     }),		-- spell_magic_polymorphrabbit\n'
            '};\n\n'
			'-- To create essences use next code:\n'
            f'Action:CreateEssencesFor(ACTION_CONST_{class_}_{spec})  '      
			'-- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)\n'
            f'local A = setmetatable(Action[ACTION_CONST_{class_}_{spec}'
            '], { __index = Action })'
			
			)
        return lua_spells

    def print_items(self):
        """
        Print the items object in lua context.
        """
        class_ = self.player.class_.lua_name()
        spec = self.player.spec.lua_name()
        lua_items = (
            '-- Items\n'
            f'if not Item.{class_} then Item.{class_} = {{}} end\n'
            f'Item.{class_}.{spec} = {{\n')
        for i, item in enumerate(self.items.values()):
            item_id = str(ITEM_INFO.get(item.simc, item.iid))
            lua_items += f'  {item.lua_name():33}= Item({item_id})'
            lua_items += ',\n' if i < len(self.items) - 1 else '\n'
        lua_items += (
            '};\n'
            f'local I = Item.{class_}.{spec};\n')
        string = ''
        return string

    def print_variables(self):
        """
        Print the variables object in lua context.
        """
        lua_variables = ''
        if len(self.variables) > 0:
            lua_variables = ('------------------------------------------\n'
            '---------------- VARIABLES ---------------\n'
            '------------------------------------------\n'			
            )
            for var in self.variables.values():
                lua_variables += f'local {var.lua_name()} = {var.default};\n'
            lua_variables += f'\nA.Listener:Add("ACTION_EVENT_COMBAT_TRACKER", "PLAYER_REGEN_ENABLED", 				function()\n'
            for var in self.variables.values():
                lua_variables += f'  {var.lua_name()} = {var.default}\n'
            lua_variables += f'	end \n'
            lua_variables += f'end)\n'
			
        return lua_variables

    def print_inflight(self):
        """
        Print the inflight registrations.
        """
        lua_inflight = ''
        for spell in self.inflight.values():
            lua_inflight += f'A.{spell.lua_name()}:RegisterInFlight()\n'
        return ''

    def print_custom_code(self):
        """
        Print the custom code.
        """
        return '\n'.join(self.custom_code)

    def print_ranges(self):
        """
        Print the custom code.
        """
        lua_ranges = ", ".join(str(r) for r in sorted(self.ranges, reverse=True))
        return (f'local EnemyRanges = {{{lua_ranges}}}\n'
                f'local function UpdateRanges()\n'
                f'  for _, i in ipairs(EnemyRanges) do\n'
                f'    HL.GetEnemies(i);\n'
                f'  end\n'
                f'end\n')

    def print_settings(self):
        """
        Print additional settings.
        """
        class_ = self.player.class_.lua_name()
        spec = self.player.spec.lua_name()
        return ('')

    def print_lua(self):
        """
        Print the context.
        """
        newline = '\n' if self.custom_code else ''
        return (
            f'{self.HEADER}\n'
            f'{self.CONTENT_HEADER}\n'
            f'{self.print_spells()}\n'
            f'{self.print_items()}\n'
            f'{self.print_settings()}\n'
            f'{self.print_variables()}\n'
            f'{self.print_ranges()}\n'
            f'{self.print_inflight()}\n'
            f'{self.print_custom_code()}{newline}')
