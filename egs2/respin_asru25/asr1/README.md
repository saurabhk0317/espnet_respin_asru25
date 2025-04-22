# MADASR 2.0 Challenge Baseline Results

This repository provides baseline recipes for all tracks of the **MADASR 2.0 Challenge**, which focuses on building robust, multilingual and multidialect automatic speech recognition (ASR) systems for Indian languages using the RESPIN corpus.

It supports:

- Multilingual training  
- Auxiliary tasks (e.g., language identification)  
- Pretrained models (e.g., IndicWav2Vec)  
- Evaluation across low-resource and high-resource settings  

Track 4 support will be added soon.

---

## Track Definitions

The challenge includes four tracks, each reflecting a different resource and transfer setting:

### Track 1: Low-Resource (In-Corpus Only)
Train a **multilingual ASR system from scratch** using only the **30-hour per language RESPIN subset**.  

### Track 2: High-Resource (In-Corpus Only)
Train using the **full 150-hour per language RESPIN dataset** without external corpora.  

### Track 3: Low-Resource + External
Train using the **30-hour RESPIN subset** plus **public corpora or pretrained models**.  

### Track 4: High-Resource + External *(Coming Soon)*
Train using the **full 150-hour RESPIN dataset** plus **external corpora and/or pretrained models**.  

---

## Input Format (Example)

```text
<utt_id> [<lang>] <transcription>

# Example
IISc_RESPIN_bh_D1_10001_845401_M_AGRI_103696_10532820 [bh]  शलजम में एंटीऑक्सीडेंट बहुते अधिका होला
IISc_RESPIN_bn_D1_20050_721101_F_AGRI_200876_20809056 [bn]  চাষের জমিতে যে ফসল গুলা উঠে সেগুলাকে শুকাতে দেয়
```

## Ex:
```
./run_baseline_track1.sh
./run_baseline_track2.sh
./run_baseline_track3.sh
```

## RESULTS (dev set)

## Environments
- python version: `3.10.12 (main, Feb 4 2025, 14:57:36) [GCC 11.4.0]`
- espnet version: `espnet 202503`
- pytorch version: `pytorch 2.3.0+cu121`
- Git hash: `0cc9d62673c1461efe37632aeab297a311bcd7f0`
  - Commit date: `Sat Apr 12 17:53:44 2025 -0400`
- Pretrained Model (track 3): IndicWav2Vec (Base) - https://github.com/AI4Bharat/IndicWav2Vec

## Overall Results

| Track   | Overall CER | Overall WER | LID Accuracy | Hugging Face Model |
|---------|-------------|-------------|--------------|---------------------|
| Track 1 | 4.06%       | 17.28%      | 97.41%       | [Track 1](https://huggingface.co/saurabhk0322/respin_asru25_track1) |
| Track 2 | 3.61%       | 15.72%      | 96.58%       | [Track 2](https://huggingface.co/saurabhk0322/respin_asru25_track2) |
| Track 3 | 4.36%       | 18.45%      | 96.92%       | [Track 3](https://huggingface.co/saurabhk0322/respin_asru25_track3) |

---

## Language-wise CER/WER (%)

| Language | Track 1 CER | Track 1 WER | Track 2 CER | Track 2 WER | Track 3 CER | Track 3 WER |
|----------|-------------|-------------|-------------|-------------|-------------|-------------|
| bh       | 3.86%       | 14.84%      | 3.59%       | 13.77%      | 4.12%       | 15.61%      |
| bn       | 4.60%       | 18.35%      | 4.11%       | 16.38%      | 5.01%       | 20.11%      |
| ch       | 3.00%       | 11.48%      | 2.61%       | 10.06%      | 3.36%       | 12.43%      |
| kn       | 4.44%       | 23.58%      | 3.94%       | 21.95%      | 4.71%       | 24.57%      |
| mg       | 5.29%       | 19.18%      | 4.59%       | 17.26%      | 5.55%       | 20.64%      |
| mr       | 3.36%       | 16.10%      | 2.76%       | 13.50%      | 3.63%       | 17.21%      |
| mt       | 4.43%       | 16.99%      | 4.36%       | 17.34%      | 4.79%       | 18.48%      |
| te       | 3.88%       | 22.13%      | 3.41%       | 19.64%      | 4.25%       | 23.72%      |

---

## Dialect-wise CER/WER (%) by Language and District

### Bhojpuri (bh)

| District (ID)            | Track 1 CER | Track 1 WER | Track 2 CER | Track 2 WER | Track 3 CER | Track 3 WER |
|--------------------------|-------------|-------------|-------------|-------------|-------------|-------------|
| EAST CHAMPARAN / DEORIA (D1)      | 4.05%       | 15.57%      | 3.54%       | 13.54%      | 4.42%       | 16.56%      |
| VARANASI (D2)            | 3.77%       | 14.45%      | 3.65%       | 14.40%      | 4.15%       | 15.49%      |
| SARAN (D3)               | 3.75%       | 14.50%      | 3.56%       | 13.37%      | 3.79%       | 14.77%      |

### Bengali (bn)

| District (ID)                | Track 1 CER | Track 1 WER | Track 2 CER | Track 2 WER | Track 3 CER | Track 3 WER |
|-----------------------------|-------------|-------------|-------------|-------------|-------------|-------------|
| WEST MEDINIPORE (D1)        | 4.47%       | 19.15%      | 3.92%       | 16.05%      | 4.55%       | 19.70%      |
| DINAJPUR DAKSHIN (D2)       | 3.25%       | 12.54%      | 2.93%       | 10.75%      | 3.77%       | 14.30%      |
| SOUTH 24 PARGANAS (D3)      | 3.35%       | 13.68%      | 2.93%       | 12.37%      | 3.80%       | 15.79%      |
| PURULIA (D4)                | 7.10%       | 26.50%      | 6.38%       | 24.19%      | 7.68%       | 28.25%      |
| JALPAIGURI (D5)             | 4.83%       | 19.89%      | 4.37%       | 18.52%      | 5.25%       | 22.51%      |

### Chhattisgarhi (ch)

| District (ID)     | Track 1 CER | Track 1 WER | Track 2 CER | Track 2 WER | Track 3 CER | Track 3 WER |
|-------------------|-------------|-------------|-------------|-------------|-------------|-------------|
| BILASPUR (D1)     | 3.16%       | 11.64%      | 2.68%       | 9.95%       | 3.23%       | 11.98%      |
| RAIGARH (D2)      | 2.71%       | 10.44%      | 2.23%       | 8.57%       | 3.13%       | 11.26%      |
| KABIRDHAM (D3)    | 2.82%       | 11.27%      | 2.66%       | 10.79%      | 3.35%       | 12.61%      |
| SARGUJAA (D4)     | 3.32%       | 12.64%      | 2.87%       | 10.98%      | 3.73%       | 13.94%      |

### Kannada (kn)

| District (ID)   | Track 1 CER | Track 1 WER | Track 2 CER | Track 2 WER | Track 3 CER | Track 3 WER |
|----------------|-------------|-------------|-------------|-------------|-------------|-------------|
| BELLARY (D1)    | 4.53%       | 22.93%      | 3.69%       | 21.10%      | 4.51%       | 24.24%      |
| MANGALORE (D2)  | 1.49%       | 10.11%      | 1.20%       | 8.06%       | 1.45%       | 10.10%      |
| DHARWAD (D3)    | 7.37%       | 37.15%      | 6.57%       | 35.35%      | 8.14%       | 39.08%      |
| GULBURGA (D4)   | 7.22%       | 36.15%      | 6.80%       | 34.93%      | 7.59%       | 36.79%      |
| MYSORE (D5)     | 1.88%       | 12.87%      | 1.69%       | 11.58%      | 2.17%       | 14.00%      |

### Magahi (mg)

| District (ID)     | Track 1 CER | Track 1 WER | Track 2 CER | Track 2 WER | Track 3 CER | Track 3 WER |
|-------------------|-------------|-------------|-------------|-------------|-------------|-------------|
| PATNA (D1)        | 5.68%       | 19.97%      | 4.97%       | 18.18%      | 5.95%       | 21.21%      |
| LAKHISARAI (D2)   | 4.14%       | 15.82%      | 3.77%       | 14.86%      | 4.73%       | 18.08%      |
| VAISHALI (D3)     | 5.39%       | 20.56%      | 4.64%       | 18.01%      | 5.54%       | 21.71%      |
| KISHANGANJ (D4)   | 5.94%       | 20.40%      | 4.98%       | 18.01%      | 6.00%       | 21.58%      |

### Maithili (mt)

| District (ID)     | Track 1 CER | Track 1 WER | Track 2 CER | Track 2 WER | Track 3 CER | Track 3 WER |
|-------------------|-------------|-------------|-------------|-------------|-------------|-------------|
| SAMASTIPUR (D1)   | 4.09%       | 15.77%      | 4.15%       | 16.08%      | 4.34%       | 17.51%      |
| MADHEPURA (D2)    | 5.56%       | 20.02%      | 5.03%       | 19.29%      | 6.12%       | 21.85%      |
| DARBHANGA (D3)    | 3.47%       | 14.41%      | 4.03%       | 17.00%      | 3.81%       | 15.90%      |
| BHAGALPUR (D4)    | 4.60%       | 17.79%      | 4.24%       | 16.96%      | 4.87%       | 18.63%      |

### Marathi (mr)

| District (ID)     | Track 1 CER | Track 1 WER | Track 2 CER | Track 2 WER | Track 3 CER | Track 3 WER |
|-------------------|-------------|-------------|-------------|-------------|-------------|-------------|
| SINDHUDURG (D1)   | 3.82%       | 19.05%      | 3.47%       | 17.36%      | 4.37%       | 21.62%      |
| NASHIK / DHULE (D2)  | 3.23%       | 16.30%      | 2.47%       | 12.87%      | 3.30%       | 15.96%      |
| PUNE (D3)         | 2.76%       | 12.40%      | 2.28%       | 10.38%      | 3.24%       | 14.27%      |
| NAGPUR (D4)       | 3.65%       | 16.57%      | 2.81%       | 13.34%      | 3.59%       | 16.92%      |

### Telugu (te)

| District (ID)     | Track 1 CER | Track 1 WER | Track 2 CER | Track 2 WER | Track 3 CER | Track 3 WER |
|-------------------|-------------|-------------|-------------|-------------|-------------|-------------|
| GUNTUR (D1)       | 3.34%       | 18.73%      | 3.08%       | 17.69%      | 3.62%       | 20.30%      |
| CHITTOOR (D2)     | 2.95%       | 18.55%      | 2.51%       | 17.18%      | 3.56%       | 20.73%      |
| KARIMNAGAR (D3)   | 4.03%       | 22.64%      | 3.47%       | 19.51%      | 4.51%       | 25.01%      |
| VIZAG (D4)        | 5.22%       | 28.66%      | 4.58%       | 24.20%      | 5.30%       | 28.87%      |


### Language and District Mapping Table
| Language Code | Full Language Name | Dialect ID | District Name          |
|---------------|---------------------|-------------|------------------------|
| bh            | Bhojpuri           | D1          | EAST CHAMPARAN         |
| bh            | Bhojpuri           | D2          | VARANASI               |
| bh            | Bhojpuri           | D3          | SARAN                  |
| bn            | Bengali            | D1          | WEST MEDINIPORE        |
| bn            | Bengali            | D2          | DINAJPUR DAKSHIN       |
| bn            | Bengali            | D3          | SOUTH 24 PARGANAS      |
| bn            | Bengali            | D4          | PURULIA                |
| bn            | Bengali            | D5          | JALPAIGURI             |
| ch            | Chhattisgarhi      | D1          | BILASPUR               |
| ch            | Chhattisgarhi      | D2          | RAIGARH                |
| ch            | Chhattisgarhi      | D3          | KABIRDHAM              |
| ch            | Chhattisgarhi      | D4          | SARGUJAA               |
| kn            | Kannada            | D1          | BELLARY                |
| kn            | Kannada            | D2          | MANGALORE              |
| kn            | Kannada            | D3          | DHARWAD                |
| kn            | Kannada            | D4          | GULBURGA               |
| kn            | Kannada            | D5          | MYSORE                 |
| mg            | Magahi             | D1          | PATNA                  |
| mg            | Magahi             | D2          | LAKHISARAI             |
| mg            | Magahi             | D3          | VAISHALI               |
| mg            | Magahi             | D4          | KISHANGANJ             |
| mr            | Marathi            | D1          | SINDHUDURG             |
| mr            | Marathi            | D2          | NASHIK / DHULE         |
| mr            | Marathi            | D3          | PUNE                   |
| mr            | Marathi            | D4          | NAGPUR                 |
| mt            | Maithili           | D1          | SAMASTIPUR             |
| mt            | Maithili           | D2          | MADHEPURA              |
| mt            | Maithili           | D3          | DARBHANGA              |
| mt            | Maithili           | D4          | BHAGALPUR              |
| te            | Telugu             | D1          | GUNTUR                 |
| te            | Telugu             | D2          | CHITTOOR               |
| te            | Telugu             | D3          | KARIMNAGAR             |
| te            | Telugu             | D4          | VIZAG                  |

