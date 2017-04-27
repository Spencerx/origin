#!/bin/bash

# Copyright 2017 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -o errexit
set -o nounset
set -o pipefail

export REGISTRY=quay.io/kubernetes-service-catalog/

docker login -e="${QUAY_EMAIL}" -u "${QUAY_USERNAME}" -p "${QUAY_PASSWORD}" quay.io

if [[ -n "${TRAVIS_TAG}" ]]; then
    echo "Pushing images with tag ${TRAVIS_TAG}."
    VERSION="${TRAVIS_TAG}" make push
elif [[ "${TRAVIS_PULL_REQUEST}" == "false" && "${TRAVIS_BRANCH}" == "master" ]]; then
    echo "Pushing images with sha tag."
    make push
fi
