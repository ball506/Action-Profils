#!/usr/bin/env bash

python -m actiongenerator -p $(ls profiles/PreRaids/*.simc)
python -m actiongenerator -p $(ls profiles/Tier22/*.simc)
python -m actiongenerator -p $(ls profiles/Tier23/*.simc)
python -m actiongenerator -p $(ls profiles/Tier24/*.simc)