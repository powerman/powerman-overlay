# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=(python3_{10..12} pypy3)

inherit distutils-r1 pypi

DESCRIPTION="A pythonic generic language server"
HOMEPAGE="https://github.com/BerriAI/litellm https://pypi.org/project/litellm/"
SRC_URI="https://files.pythonhosted.org/packages/source/${PN::1}/${PN}/${P}.tar.gz"

S=${WORKDIR}/${P}

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-python/python-dotenv[${PYTHON_USEDEP}]
	dev-python/tiktoken
	dev-python/importlib-metadata[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/certifi[${PYTHON_USEDEP}]
	dev-python/aiohttp[${PYTHON_USEDEP}]
	dev-python/aioboto3[${PYTHON_USEDEP}]
	dev-python/tenacity[${PYTHON_USEDEP}]
	dev-python/pydantic[${PYTHON_USEDEP}]
	dev-python/jsonschema[${PYTHON_USEDEP}]
	sci-libs/tokenizers
	dev-python/httpx[${PYTHON_USEDEP}]
	dev-python/anyio[${PYTHON_USEDEP}]
	dev-python/backoff
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/uvicorn[${PYTHON_USEDEP}]
	www-servers/gunicorn
	dev-python/boto3
	dev-python/redis[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pandas
	dev-python/pynacl[${PYTHON_USEDEP}]
	dev-python/prometheus-client[${PYTHON_USEDEP}]
	dev-python/orjson
	dev-python/APScheduler
	dev-python/pyjwt
	dev-python/python-multipart[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/opentelemetry-api
	dev-python/opentelemetry-sdk
	dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/openai
	dev-python/async-generator
"
RDEPEND="${DEPEND}"
