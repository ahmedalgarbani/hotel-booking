from datetime import datetime
import pytz

def change_date_format2(date_str):
    """
    Convierte una cadena de fecha en formato 'YYYY-MM-DD' a un objeto datetime con zona horaria UTC.
    """
    date_obj = datetime.strptime(date_str, "%Y-%m-%d")
    
    utc_timezone = pytz.UTC
    date_obj_utc = date_obj.replace(tzinfo=utc_timezone)  
    
    print(date_obj_utc) 
    return date_obj_utc

def change_date_format(date_str):
    """
    Convierte una cadena de fecha en formato 'MM/DD/YYYY' a un objeto datetime.
    """
    date_obj = datetime.strptime(date_str, "%m/%d/%Y")  
    formatted_date_str = date_obj.strftime("%Y-%m-%d 00:00:00")
    formatted_date = datetime.strptime(formatted_date_str, "%Y-%m-%d 00:00:00")
 
    print(formatted_date) 
    return formatted_date
