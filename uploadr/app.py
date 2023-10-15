from flask import Flask, request, redirect, url_for, render_template
from flaskext.mysql import MySQL
import os
import json
import glob
from uuid import uuid4
from uploadr.utils import createMetaData
from uploadr.model import insertMetaData, selectMetaData


app = Flask(__name__)
mysql = MySQL()
app.config["MYSQL_DATABASE_USER"] = "root"
app.config["MYSQL_DATABASE_PASSWORD"] = ""
app.config["MYSQL_DATABASE_DB"] = "forensictool"
app.config["MYSQL_DATABASE_HOST"] = "localhost"
mysql.init_app(app)
conn = mysql.connect()


@app.route("/")
def index():
    return render_template("index.html")


@app.route("/getrecords", methods=["GET"])
def getrecords():
    recordesOutput = []
    record = {}
    result = selectMetaData(conn)
    for val in result:
        record = {
            "filename": val[1],
            "type": val[3],
            "size": val[2],
            "udate": val[4],
            "name": val[5],
            "email": val[6],
            "ssno": val[7],
        }
        recordesOutput.append(record)
    return ajax_response(True, recordesOutput)


@app.route("/upload", methods=["POST"])
def upload():
    """Handle the upload of a file."""
    form = request.form

    # Create a unique "session ID" for this particular batch of uploads.
    upload_key = str(uuid4())

    # Is the upload using Ajax, or a direct POST by the form?
    is_ajax = False
    if form.get("__ajax", None) == "true":
        is_ajax = True

    # Target folder for these uploads.
    target = "uploadr/static/uploads/{}".format(upload_key)
    try:
        os.mkdir(target)
    except:
        if is_ajax:
            return ajax_response(
                False, "Couldn't create upload directory: {}".format(target)
            )
        else:
            return "Couldn't create upload directory: {}".format(target)

    print("=== Form Data ===")
    for key, value in list(form.items()):
        print(key, "=>", value)

    for upload in request.files.getlist("file"):
        filename = upload.filename.rsplit("/")[0]
        destination = "/".join([target, filename])
        print("Accept incoming file:", filename)
        print("Save it to:", destination)
        upload.save(destination)
        result = createMetaData(destination, filename)
        insertMetaData(conn, result)
    if is_ajax:
        return ajax_response(True, result)


def ajax_response(status, msg):
    status_code = "ok" if status else "error"
    return json.dumps(
        dict(
            status=status_code,
            msg=msg,
        ),
        indent=4,
        sort_keys=True,
        default=str,
    )
