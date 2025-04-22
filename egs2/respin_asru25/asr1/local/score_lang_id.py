import argparse
import re
from collections import defaultdict
from jiwer import cer, wer

def get_parser():
    parser = argparse.ArgumentParser(description="Score ASR + LID")
    parser.add_argument("--ref_text", type=str, required=True, help="Path to reference text")
    parser.add_argument("--hyp_text", type=str, required=True, help="Path to decoded text")
    parser.add_argument("--utt2dial", type=str, required=True, help="Path to utt2dial file")
    parser.add_argument("--out", type=str, default="result.txt", help="Output result file")
    return parser

def load_text(path):
    utt2lid = {}
    utt2text = {}
    with open(path, encoding="utf-8") as f:
        for line in f:
            parts = line.strip().split(maxsplit=2)
            if len(parts) < 3:
                continue
            uttid, lid, text = parts
            utt2lid[uttid] = lid
            utt2text[uttid] = text
    return utt2lid, utt2text

def load_utt2dial(path):
    utt2dial = {}
    with open(path, encoding="utf-8") as f:
        for line in f:
            utt, dial = line.strip().split()
            utt2dial[utt] = dial
    return utt2dial

def strip_lid(text):
    return re.sub(r"^\[[^\]]+\]\s*", "", text.strip())

def extract_lang(dialect_id):
    return dialect_id.split("_")[0]

def write_and_print(msg, f):
    print(msg)
    f.write(msg + "\n")

def main():
    args = get_parser().parse_args()

    ref_lids, ref_texts = load_text(args.ref_text)
    hyp_lids, hyp_texts = load_text(args.hyp_text)
    utt2dial = load_utt2dial(args.utt2dial)

    global_refs, global_hyps = [], []
    lid_total, lid_correct = 0, 0

    lang_cer, lang_wer = defaultdict(list), defaultdict(list)
    dial_cer, dial_wer = defaultdict(list), defaultdict(list)

    with open(args.out, "w", encoding="utf-8") as out:
        for uttid in ref_texts:
            if uttid not in hyp_texts or uttid not in utt2dial:
                continue

            ref_lid = ref_lids[uttid]
            hyp_lid = hyp_lids[uttid]
            ref = strip_lid(ref_texts[uttid])
            hyp = strip_lid(hyp_texts[uttid])
            dial = utt2dial[uttid]
            lang = extract_lang(dial)

            global_refs.append(ref)
            global_hyps.append(hyp)

            lid_total += 1
            if ref_lid == hyp_lid:
                lid_correct += 1

            c = cer(ref, hyp)
            w = wer(ref, hyp)
            lang_cer[lang].append(c)
            lang_wer[lang].append(w)
            dial_cer[dial].append(c)
            dial_wer[dial].append(w)

        write_and_print("Language-wise CER/WER (%):", out)
        for lang in sorted(lang_cer.keys()):
            avg_cer = 100 * sum(lang_cer[lang]) / len(lang_cer[lang])
            avg_wer = 100 * sum(lang_wer[lang]) / len(lang_wer[lang])
            write_and_print(f"{lang}\tCER: {avg_cer:.2f}%\tWER: {avg_wer:.2f}%", out)

        write_and_print("\nDialect-wise CER/WER (%):", out)
        for dial in sorted(dial_cer.keys()):
            avg_cer = 100 * sum(dial_cer[dial]) / len(dial_cer[dial])
            avg_wer = 100 * sum(dial_wer[dial]) / len(dial_wer[dial])
            write_and_print(f"{dial}\tCER: {avg_cer:.2f}%\tWER: {avg_wer:.2f}%", out)

        overall_cer = 100 * cer(global_refs, global_hyps)
        overall_wer = 100 * wer(global_refs, global_hyps)
        write_and_print(f"\nOverall CER: {overall_cer:.2f}%", out)
        write_and_print(f"Overall WER: {overall_wer:.2f}%", out)

        lid_acc = lid_correct / lid_total if lid_total > 0 else 0.0
        write_and_print(f"\nLID Accuracy: {lid_acc:.4f} ({lid_correct}/{lid_total})", out)

if __name__ == "__main__":
    main()
