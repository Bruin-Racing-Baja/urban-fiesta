# Bruin Racing M21 Simscape Model
*project urban-fiesta*

I'm fucking hammered so sorry if this documentation doesn't make sense.

## Project Scope

This model is adapted from a [Mathworks tutorial](https://www.mathworks.com/videos/modeling-a-vehicle-with-continuously-variable-transmission-1554467867519.html?s_tid=srchtitle) on CVT modeling with Simscape. It is intended for basic tuning insight while vehicle data is unavailable due to COVID-19.

## Structure

The `main.slx` is the overall system model. It consists of four blocks: **Engine**, **CVT**, **Gearbox**, and **Vehicle & Driveline**. Each of these is a referenced subsystem that can be edited and tested individually.

## Current State

### Engine Subsystem

The engine is based on data provided be an SAE India team found in the [Mathworks tutorial](https://www.mathworks.com/videos/modeling-a-vehicle-with-continuously-variable-transmission-1554467867519.html?s_tid=srchtitle) on CVT modeling. The block includes inertia values for the crankshaft and flywheel. The idle and redline speed control values are tuned empirically based on personal experience, as is the external rotational damper block.

*Future work for this subsystem would involve gathering dyno data with known throttle commands and shaping the block response to match this data.*
