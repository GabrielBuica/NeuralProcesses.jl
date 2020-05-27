#!/usr/bin/env bash

set -e

MODEL_LOSSES="
    convcnp,loglik
    convnp,loglik
    convnp,loglik-iw
    convnp,elbo
    anp,loglik
    anp,loglik-iw
    anp,elbo
    np,loglik
    np,loglik-iw
    np,elbo
    "
DATA_SETS="
    eq
    matern52
    noisy-mixture
    weakly-periodic
    sawtooth
    "

line () {
    echo "------------------------------------------------------"
}

line
echo "Models and losses:"
for model_loss in $MODEL_LOSSES
do
    IFS="," read model loss <<< "$model_loss"
    echo "    $model + $loss"
done
echo "Data sets:"
for data in $DATA_SETS
do
    echo "    $data"
done

line
echo EVALUATING
for model_loss in $MODEL_LOSSES
do
    IFS="," read model loss <<< "$model_loss"
    for data in $DATA_SETS
    do
        line
        echo "Model:    $model"
        echo "Loss:     $loss"
        echo "Data set: $data"
        ./eval.sh \
            --models-dir models_bake-off \
            --data $data \
            --model $model \
            --loss $loss
    done
done