# Voltage-Mode Closed-Loop Control of a Synchronous DC-DC Boost Converter

This repository hosts the mathematical modeling, small-signal linearization, and MATLAB/Simulink closed-loop verification of a high-efficiency Synchronous DC-DC Boost Converter designed for Electric Vehicle (EV) applications. The system steps up a $12\text{V}$ input to a highly regulated $48\text{V}$, $360\text{W}$ output power stage operating in Continuous Conduction Mode.

## Proportional-Integral (PI) Control
The primary engineering challenge of this system centers around its non-linear small-signal behavior and the presence of an inherent Right-Half Plane (RHP) zero ($s_z = \frac{R(1-D)^2}{L}$). The RHP zero causes a non-minimum phase characteristics undershoot during transients, making baseline closed-loop operation highly unstable. 

To overcome this instability, a robust Voltage-Mode Feedback PI Controller was developed and fine-tuned:
**Parasitic Damping:** An Equivalent Series Resistance (ESR) of $1\times 10^{-6}\text{ }\Omega$ was integrated into the $58.59\text{ }\mu\text{F}$ capacitor bank model to capture realistic high-frequency conduction losses and damp oscillations.
**Gain Optimization:** To resolve RHP zero tracking conflict and suppress aggressive limit-cycle oscillations, the loop gains were tuned down to specialized, precise parameters ($K_p = 0.000229$, $K_i = 5$).
**Disturbance Rejection:** The tailored closed-loop system actively counteracts sudden input-current shifts and momentary voltage sags during step-load changes simulating vehicle acceleration ($5.3\text{ }\Omega$ to $8\text{ }\Omega$).

## Verification & Constraints Compliance
Simulink scopes verify that the optimized controller forces the feedback error signal to zero immediately following transient conditions:
**Steady-State Tracking:** Achieves absolute zero steady-state error ($e_{ss} = 0\text{V}$) across all loading conditions.
**Voltage Ripple ($\Delta v_o$):** Tightly bounded at $\approx 0.4\text{V}$, safely below the strict $2\%$ safety criteria ($\le 0.96\text{V}$).
* **Current Ripple ($\Delta i_L$):** Maintained at $\approx 8.5\text{A}$ through the $7.5\text{ }\mu\text{H}$ inductor, well within the $40\%$ constraint boundary ($\le 12\text{A}$).
