from datetime import datetime


def insertMetaData(conn, data):
    mycursor = conn.cursor()
    sql = "INSERT INTO metadata (finename, size, type, uploaded_date, author_id) VALUES (%s, %s, %s, %s, %s)"
    today = datetime.today().strftime("%Y-%m-%d")
    val = (data["filename"], data["size"], data["type"], today, 1)
    mycursor.execute(sql, val)
    conn.commit()


def selectMetaData(conn):
    mycursor = conn.cursor()
    sql = "SELECT * FROM vw_metadata order by id DESC"
    mycursor.execute(sql)
    return mycursor.fetchall()
