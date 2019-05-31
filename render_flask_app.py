import os

from flask import Flask, jsonify, request

from render import Render

app = Flask(__name__)

env_vars = {
    "TEMPLATES_DIR": os.environ.get('TEMPLATES_DIR'),
    "VARS_DIR": os.environ.get('VARS_DIR'),
    "TEMPLATE": os.environ.get('TEMPLATE'),
    "VARIABLES": os.environ.get('VARIABLES'),
    "TEMPLATES_DIR_FILES": os.listdir(os.environ.get('TEMPLATES_DIR')),
    "VARS_DIR_FILES": os.listdir(os.environ.get('VARS_DIR'))
}

env_vars_list = os.environ


@app.route('/')
def get_vars():
    return jsonify(env_vars), 200


@app.route('/rend/<template>/<variables>', methods=['GET'])
def get_content(template, variables):
    os.environ['TEMPLATE'] = template
    os.environ['VARIABLES'] = variables
    r = Render(os.environ['TEMPLATE'], os.environ['VARIABLES'])
    result = r.rend_template("dummy")
    if result is None:
        result = ""

    return result, 200


@app.route('/rendenv/<template>/<variables>', methods=['POST'])
def get_content_with_env(template, variables):
    input_json = request.get_json(force=True)
    os.environ['TEMPLATE'] = template
    os.environ['VARIABLES'] = variables
    for key, value in input_json.items():
        if key not in env_vars_list:
            os.environ[key] = value

    r = Render(os.environ['TEMPLATE'], os.environ['VARIABLES'])
    result = r.rend_template("dummy")
    if result is None:
        result = ""

    return result, 200


app.run(host='0.0.0.0')
