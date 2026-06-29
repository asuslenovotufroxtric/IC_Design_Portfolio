# Frequency-Division Multiplexing System

## 1. Project Overview

This project focuses on the design and LTspice simulation of a frequency-division multiplexing system.

The main objective is to construct the transmitter-side multiplexing signal by generating a 38 kHz carrier from a 19 kHz pilot signal and combining multiple signal components into one frequency-division multiplexed output.

This project was completed as part of the Signals and Systems course.

---

## 2. My Role

I was responsible for Part 1 of the project: Frequency-Division Multiplexing System.

My work focused on:

* Designing and simulating the 19 kHz to 38 kHz frequency doubler
* Using a full-wave rectifier / absolute-value circuit to generate harmonic components
* Extracting and adjusting the 38 kHz component
* Designing the BPF1 band-pass filter
* Building the multiplexed signal `V(Y)`
* Verifying the circuit behavior using LTspice transient simulation and FFT analysis

---

## 3. System Flow

The transmitter-side multiplexing system follows this signal flow:

```text
19 kHz Pilot Signal
        ↓
Full-Wave Rectifier / ABS Circuit
        ↓
Frequency Doubling: 19 kHz → 38 kHz
        ↓
BPF1 Band-Pass Filter
        ↓
38 kHz Carrier Signal
        ↓
Frequency-Division Multiplexing
        ↓
Multiplexed Signal V(Y)
```

---

## 4. Frequency Doubler: 19 kHz to 38 kHz

The 38 kHz signal is generated from a 19 kHz input signal using a full-wave rectifier structure.

The input signal is:

```text
Vin = 0.1cos(2π × 19000t)
```

After full-wave rectification, the signal contains harmonic components. The second harmonic component is used to obtain the 38 kHz signal.

The design process included:

* Simulating the rectified waveform
* Performing FFT analysis to observe harmonic components
* Measuring the amplitude of the 2f0 component
* Adjusting the amplifier gain to obtain the required 38 kHz output amplitude

---

## 5. BPF1 Design

BPF1 is designed to extract the desired 38 kHz component from the rectified signal.

The filter design process included:

* Selecting passband and stopband specifications
* Deriving the normalized Butterworth filter
* Performing frequency scaling
* Converting the theoretical filter into an LTspice circuit
* Simulating both time-domain waveform and frequency-domain response

The goal of this stage is to suppress unwanted harmonic components while preserving the 38 kHz carrier signal.

---

## 6. Multiplexed Signal V(Y)

After generating the 38 kHz carrier, the multiplexed signal is constructed as:

```text
V(Y) = V(L) + [V(R) × V(38k)] + V(19k)
```

Where:

* `V(L)` is the left-channel baseband signal
* `V(R)` is the right-channel signal
* `V(38k)` is the generated 38 kHz carrier
* `V(19k)` is the pilot signal

The multiplexed signal contains both low-frequency baseband components and frequency-shifted components around the 38 kHz carrier.

---

## 7. Simulation Results

The system was simulated using LTspice.

Main simulation outputs:

* Rectified signal waveform
* FFT spectrum of the frequency doubler output
* BPF1 output waveform
* FFT spectrum after filtering
* Multiplexed output signal `V(Y)`

Recommended image files:

```text
sim/rectified_signal.png
sim/fft_frequency_doubler.png
sim/bpf1_output.png
sim/multiplexed_signal_vy.png
```

Example README image links:

```md
![Frequency Doubler FFT](sim/fft_frequency_doubler.png)

![Multiplexed Signal VY](sim/multiplexed_signal_vy.png)
```

---

## 8. Repository Structure

```text
FDM-Multiplexing-System/
├── README.md
├── ltspice/
│   └── fdm_multiplexing.asc
├── schematics/
│   ├── frequency_doubler_19k_to_38k.png
│   ├── bpf1_schematic.png
│   └── multiplexing_system.png
├── sim/
│   ├── rectified_signal.png
│   ├── fft_frequency_doubler.png
│   ├── bpf1_output.png
│   └── multiplexed_signal_vy.png
└── reports/
    └── fdm_report.pdf
```

---

## 9. Tools Used
* LTspice
---

## 10. What I Learned

Through this project, I learned how to:

* Convert theoretical signal-processing concepts into circuit-level simulation
* Generate a 38 kHz carrier from a 19 kHz pilot signal
* Analyze harmonic components using FFT
* Design and simulate a Butterworth band-pass filter
* Understand the transmitter-side structure of a frequency-division multiplexing system
* Verify analog circuit behavior in both time and frequency domains

---

## 11. Report

The full academic report is available in:

```text
reports/fdm_report.pdf
```

