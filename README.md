# Signals Processing Project

This MATLAB project demonstrates core principles of signals and systems, implementing various signal processing techniques including signal generation, filtering, and spectral analysis.

## Project Overview

The project implements several signal processing operations:
- Signal generation with multiple frequency components
- Low-pass and high-pass Butterworth filtering
- Time and frequency domain analysis
- Energy calculations and Parseval's theorem verification
- Audio file generation and processing

## Prerequisites

- MATLAB or GNU Octave
- Signal Processing Toolbox

### For GNU Octave Users
If using GNU Octave, you'll need to install and load the signal processing package:
```octave
pkg install -forge signal  % Install signal package (if not installed)
pkg load signal           % Load the signal package
```

## Features

1. **Signal Generation**
   - Creates a composite signal with frequencies: 500Hz, 1000Hz, 1500Hz, 2000Hz
   - Sampling frequency: 10kHz

2. **Signal Processing**
   - Signal normalization and audio file generation
   - FFT computation and spectrum analysis
   - Energy calculations in time and frequency domains

3. **Filtering Operations**
   - Butterworth low-pass filter (cutoff: 1250Hz)
   - Butterworth high-pass filter (cutoff: 1250Hz)
   - Filter response visualization

## Output Files

The program generates three WAV files:
- `x1(t).wav`: Original generated signal
- `y1(t).wav`: Low-pass filtered signal
- `y2(t).wav`: High-pass filtered signal

## Visualization

The program generates multiple plots showing:
- Time domain representations of signals
- Frequency spectra
- Filter responses
- Filtered signals in both time and frequency domains

## Usage

1. Clone the repository
2. Open MATLAB/Octave
3. Navigate to the project directory
4. Run `Project.m`

## Implementation Details

- Filter Order: 20 (both LPF and HPF)
- Cutoff Frequency: 1250Hz
- Sampling Rate: 10kHz
- Signal Duration: 1 second

## Energy Analysis

The project includes energy calculations:
- Time domain energy computation
- Frequency domain energy verification
- Parseval's theorem validation

## Author
Omar Alashry
