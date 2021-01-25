# Bruin Racing M21 Simscape Model
*project urban-fiesta*

I'm fucking hammered so sorry if this documentation doesn't make sense.

## Project Scope

This model is adapted from a [Mathworks tutorial](https://www.mathworks.com/videos/modeling-a-vehicle-with-continuously-variable-transmission-1554467867519.html?s_tid=srchtitle) on CVT modeling with Simscape. It is intended for basic tuning insight while vehicle data is unavailable due to COVID-19.

## Structure

The `main.slx` is the overall system model. It consists of four blocks: **Engine**, **CVT**, **Gearbox**, and **Vehicle & Driveline**. Each of these is a referenced subsystem that can be edited and tested individually.

## Current State

get this guy a fuckin puppers

### Engine Subsystem

This subsystem is built around the generic combustion engine block from Simscape Driveline.

The engine is based on data provided be an SAE India team found in the [Mathworks tutorial](https://www.mathworks.com/videos/modeling-a-vehicle-with-continuously-variable-transmission-1554467867519.html?s_tid=srchtitle) on CVT modeling. The block includes inertia values for the crankshaft and flywheel. The idle and redline speed control values are tuned empirically based on personal experience, as is the external rotational damper block.

The test harness used for tuning is saved in a separate model as `Engine_test.slx`.

*Future work for this subsystem would involve gathering dyno data with known throttle commands and shaping the block response to match this data.*

### CVT Subsystem

This subsystem is built around the continuously variable transmission block from Simscape Driveline.

The CVT block has the correct shaft orientation but has not been altered in any other way. External blocks account for the inertia of the primary and secondary pulleys

*Future work for this subsystem would involve gathering data to calculate viscous friction coefficients at each sheave, as well as finding some overall efficiency number to account for belt losses in a broad range of operating conditions.*

### Gearbox Subsystem

This subsystem includes the fixed double reduction gears. Two simple gear blocks include the appropriate ratios and are assumed to operate at constant 95% efficiency. The inertias of each gear are accounted for in external blocks.

*No further work is necessary for this subsystem. As an optional addition we could gather data to tune the viscous loss coefficients, but a constant efficiency assumption is probably sufficient for the scope of this model.*
