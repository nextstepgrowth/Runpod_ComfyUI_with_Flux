#!/bin/bash

# huggingface token
if [[ -z "${HF_TOKEN}" ]] || [[ "${HF_TOKEN}" == "enter_your_huggingface_token_here" ]]
then
    echo "HF_TOKEN is not set, can not download flux because it is a gated repository."
else
    echo "HF_TOKEN is set, checking files..."

    if [[ ! -e "/ComfyUI/models/checkpoints/FLUX1/flux1-dev-fp8.safetensors" ]]
    then
        echo "Downloading flux1-dev-fp8.sft..."
        mkdir -p "/ComfyUI/models/checkpoints/FLUX1"
        wget -O "/ComfyUI/models/checkpoints/FLUX1/flux1-dev-fp8.safetensors" --header="Authorization: Bearer ${HF_TOKEN}" "https://huggingface.co/black-forest-labs/FLUX.1-dev/resolve/main/ae.safetensors?download=true"
    else
        echo "flux1-dev-fp8.safetensors already exists, skipping download."
    fi

    if [[ ! -e "/ComfyUI/models/controlnet/FLUX.1-dev-ControlNet-Union-Pro/diffusion_pytorch_model.safetensors" ]]
    then
        echo "Downloading diffusion_pytorch_model.safetensors..."
        mkdir -p "/ComfyUI/models/controlnet/FLUX.1-dev-ControlNet-Union-Pro"
        wget -O "/ComfyUI/models/controlnet/FLUX.1-dev-ControlNet-Union-Pro/diffusion_pytorch_model.safetensors" --header="Authorization: Bearer ${HF_TOKEN}" "https://huggingface.co/black-forest-labs/FLUX.1-dev/resolve/main/flux1-dev.safetensors?download=true"
    else
        echo "diffusion_pytorch_model.safetensors already exists, skipping download."
    fi
fi

# civitai token
if [[ -z "${CV_TOKEN}" ]] || [[ "${CV_TOKEN}" == "enter_your_civitai_token_here" ]]
then
    echo "CT_TOKEN is not set, can not download flux because it is a gated repository."
else
    echo "CT_TOKEN is set, checking files..."

    if [[ ! -e "/ComfyUI/models/loras/RetroAnimeFluxV1.safetensors" ]]
    then
        echo "Downloading RetroAnimeFluxV1.safetensors.safetensors..."
        mkdir -p "/ComfyUI/models/loras"
        wget -O "/ComfyUI/models/loras/RetroAnimeFluxV1.safetensors" "https://civitai.com/api/download/models/806265?token=${CV_TOKEN}"
    else
        echo "flux-realism-lora.safetensors already exists, skipping download."
    fi
fi

# Define the download function
download_file() {
    local dir=$1
    local file=$2
    local url=$3

    mkdir -p $dir
    if [ -f "$dir/$file" ]; then
        echo "File $dir/$file already exists, skipping download."
    else
        wget -O "$dir/$file" "$url" --progress=bar:force:noscroll
    fi
}

# Download files
# download_file "/ComfyUI/models/clip" "clip_l.safetensors" "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/clip_l.safetensors?download=true"
# download_file "/ComfyUI/models/clip" "t5xxl_fp8_e4m3fn.safetensors" "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp8_e4m3fn.safetensors?download=true"
# download_file "/ComfyUI/models/loras" "GracePenelopeTargaryenV5.safetensors" "https://huggingface.co/WouterGlorieux/GracePenelopeTargaryenV5/resolve/main/GracePenelopeTargaryenV5.safetensors?download=true"
# download_file "/ComfyUI/models/loras" "VideoAditor_flux_realism_lora.safetensors" "https://huggingface.co/VideoAditor/Flux-Lora-Realism/resolve/main/flux_realism_lora.safetensors?download=true"
# download_file "/ComfyUI/models/xlabs/loras" "Xlabs-AI_flux-RealismLora.safetensors" "https://huggingface.co/XLabs-AI/flux-RealismLora/resolve/main/lora.safetensors?download=true"
