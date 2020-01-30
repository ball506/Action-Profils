@echo off
for %%v in (profiles\Tier24\*.simc) do python -m actiongenerator -p %%v
for %%v in (profiles\Tier25\*.simc) do python -m actiongenerator -p %%v