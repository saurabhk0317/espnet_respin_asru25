#!/usr/bin/env bash
set -euo pipefail

######################################
#           CONFIGURATION            #
######################################

# Language or dataset subset
tag="small"
suffix="lid"
lang_tag="${tag}${suffix:+_$suffix}"
lang="multilingual"

# GPU and parallel job settings
gpu=0
ngpu=1
gpu_infer=false
train_nj=2
infer_nj=32

# Data and experiment directories
data_folder="data_respin/data_asru25"
dumpdir="dump/asru25/small"
expdir="exp/asru25/exp_${tag}"

# Dataset names
train_set="train_${tag}"
train_dev="dev${suffix:+_$suffix}"
test_set="dev${suffix:+_$suffix}"

# Configurations and tags
asr_config="conf/tuning/train_asr_conformer_transformer_e8_linear1024_bs6M_gacc1.yaml"
infer_config="conf/tuning/decode_transformer.yaml"
asr_tag="multilingual${suffix:+_$suffix}_con_e8_lin1024_bs6M_gacc1_ctc03"
asr_task="asr"
aux_tag=""
infer_tag="decode_lid_asr_model_valid.acc.ave"
model_ckpt="${expdir}/asr_${asr_tag}/valid.acc.ave.pth"
asr_stats_dir="${expdir}/asr_stats_raw_${lang}_char_sp"

if [ "${test_set}" = "${train_dev}" ]; then
    decode_dir="${expdir}/asr_${asr_tag}/${infer_tag}/org/${test_set}"
else
    decode_dir="${expdir}/asr_${asr_tag}/${infer_tag}/${test_set}"
fi
hyp="${decode_dir}/text"

######################################
#          MAIN EXECUTION            #
######################################

# Export GPU device
export CUDA_VISIBLE_DEVICES="${gpu}"

# NLSYMS
nlsyms_txt="${data_folder}/nlsyms.txt"

# Train if checkpoint does not exist
if [ ! -f "${model_ckpt}" ]; then
    echo "Training ASR model for ${lang_tag}..."
    ./asr_respin.sh \
        --stage 11 \
        --stop_stage 11 \
        --lang "${lang_tag}" \
        --data_folder "${data_folder}" \
        --expdir "${expdir}" \
        --dumpdir "${dumpdir}" \
        --train_set "${train_set}" \
        --valid_set "${train_dev}" \
        --test_sets "${test_set}" \
        --nlsyms_txt "${nlsyms_txt}" \
        --bpe_train_text "${data_folder}/${train_set}/text" \
        --lm_train_text "${data_folder}/${train_set}/text" \
        --audio_format "wav" \
        --feats_type "raw" \
        --feats_normalize "utt_mvn" \
        --speed_perturb_factors "0.9 1.0 1.1" \
        --token_type "char" \
        --nbpe 500 \
        --bpe_nlsyms "${nlsyms_txt}" \
        --lm_config "conf/train_lm.yaml" \
        --use_lm false \
        --asr_config "${asr_config}" \
        --asr_tag "${asr_tag}" \
        --asr_task "${asr_task}" \
        --asr_stats_dir "${asr_stats_dir}" \
        --inference_config "${infer_config}" \
        --inference_tag "${infer_tag}" \
        --inference_asr_model "valid.acc.ave.pth" \
        --inference_nj "${infer_nj}" \
        --gpu_inference "${gpu_infer}" \
        --skip_train false \
        --nj "${train_nj}" \
        --ngpu "${ngpu}" \
        --auxiliary_data_tags "${aux_tag}" \
        --local_data_opts "--stage 0 --lang ${lang_tag} --nlsyms_txt ${nlsyms_txt}" \
        --post_process_local_data_opts "--stage 2 --lang ${lang_tag} --nlsyms_txt ${nlsyms_txt}" \
        --local_score_opts "--score_lang_id true" \
        --skip_packing false \
        --skip_upload_hf false \
        --tag "${lang_tag}"
else
    echo "Model checkpoint exists: ${model_ckpt}"
fi

# Decode if not already done
if [ -f "${model_ckpt}" ] && [ ! -f "${hyp}" ]; then
    echo "Running decoding for ${lang_tag}..."
    ./asr_respin.sh \
        --stage 12 \
        --stop_stage 15 \
        --lang "multilingual" \
        --data_folder "${data_folder}" \
        --expdir "${expdir}" \
        --dumpdir "${dumpdir}" \
        --train_set "${train_set}" \
        --valid_set "${train_dev}" \
        --test_sets "${test_set}" \
        --nlsyms_txt "${nlsyms_txt}" \
        --bpe_train_text "${data_folder}/${train_set}/text" \
        --lm_train_text "${data_folder}/${train_set}/text" \
        --audio_format "wav" \
        --feats_type "raw" \
        --feats_normalize "utt_mvn" \
        --token_type "char" \
        --nbpe 500 \
        --bpe_nlsyms "${nlsyms_txt}" \
        --lm_config "conf/train_lm.yaml" \
        --use_lm false \
        --asr_config "${asr_config}" \
        --asr_tag "${asr_tag}" \
        --asr_task "${asr_task}" \
        --asr_stats_dir "${asr_stats_dir}" \
        --inference_config "${infer_config}" \
        --inference_tag "${infer_tag}" \
        --inference_asr_model "valid.acc.ave.pth" \
        --inference_nj "${infer_nj}" \
        --gpu_inference "${gpu_infer}" \
        --skip_train true \
        --nj "${train_nj}" \
        --ngpu "${ngpu}" \
        --auxiliary_data_tags "${aux_tag}" \
        --local_data_opts "--stage 0 --lang ${lang_tag} --nlsyms_txt ${nlsyms_txt}" \
        --post_process_local_data_opts "--stage 2 --lang ${lang_tag} --nlsyms_txt ${nlsyms_txt}" \
        --local_score_opts "--score_lang_id true" \
        --skip_packing false \
        --skip_upload_hf false \
        --tag "${lang_tag}" \
        --hf_repo "saurabhk0322/respin_asru25_track1"
else
    echo "Skipping decoding for ${lang_tag} (model or hyp already exists)"
fi
