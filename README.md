# Pupil dilation
A collection of helpful functions for the analysis of pupil dilation.

You can add this as a submodule to your git repository. In your project, use `git submodule add https://github.com/awiehler/pupil_dilation.git` to add,  `git submodule init` to initialize your local configuration file, and `git submodule update` to fetch updates.

`pupil_preprocessing_canonical_v03.m` calls all neccessary functions.

The functions require the signal processing toolbox in Matlab. 

## A typical preprocessing includes the following steps:

- Remove non-good states of eye-tracker (blinks etc.)
- Removed fixations outside screen center
- Excluded samples outside 3 SD (of the full session)
- Linear interpolation of missing samples +- 100ms
- A bandpass filter between 1/128Hz and 2 Hz
- Average eyes (only needed for EyeTribe)
- Downsampling (only needed for eyelink 1kHz --> 250Hz)
- Smoothing (for 1D-RFT, ONLY IF NO LOW-PASS OR BANDPASS FILTER)
- Z-scoring across the whole session
- Baseline correction in epochs (substract mean of 100ms before onset from epoch)


Antonius Wiehler <antonius.wiehler@gmail.com>
