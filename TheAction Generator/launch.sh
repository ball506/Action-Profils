#!/usr/bin/env bash

python -m actiongenerator -p $(ls profiles/Tier24/*.simc)
python -m actiongenerator -p $(ls profiles/Tier25/*.simc)