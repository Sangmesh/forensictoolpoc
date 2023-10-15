import os
from datetime import datetime

# constants
AUTHOR_NAME = "Sangmesh Seege"
AUTHOR_EMAIL = "s.r.seege@gmail.com"
AUTHOR_SSNO = "234533457"


def createMetaData(destination, filename):
    resultArray = {}
    resultArray["filename"], resultArray["type"] = os.path.splitext(filename)
    resultArray["type"] = resultArray["type"].strip(".")
    resultArray["size"] = round(os.stat(destination).st_size / 1024)
    resultArray["udate"] = datetime.today().strftime("%Y-%m-%d")
    resultArray["name"] = AUTHOR_NAME
    resultArray["email"] = AUTHOR_EMAIL
    resultArray["ssno"] = AUTHOR_SSNO
    return resultArray
