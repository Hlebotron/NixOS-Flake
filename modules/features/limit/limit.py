from datetime import date
import time
import os


root_dir = "/opt/limit"

max_mins = 15
user = "maxim"
tick_len = 10
ticks_used = 0

try:
    with open(f"{root_dir}/tick_length_secs", 'x') as file:
        file.write(f"{tick_len}")
        print("Creating file tick_length_secs")
except FileExistsError:
    try:
        tick_len = int(open(f"{root_dir}/tick_length_secs").read().strip())
    except ValueError:
        print("Supplied value in tick_length_secs is invalid")
        raise ValueError

try:
    with open(f"{root_dir}/max_mins", 'x') as file:
        file.write(f"{max_mins}")
        print("Creating file max_mins")
except FileExistsError:
    try:
        max_mins = int(open(f"{root_dir}/max_mins").read().strip())
    except ValueError:
        print("Supplied value in max_mins is invalid")
        raise ValueError

try:
    with open(f"{root_dir}/date", 'x') as file:
        file.write(date.today().isoformat())
        print("Creating file date")
except FileExistsError:
    pass

try:
    with open(f"{root_dir}/ticks_left", 'x') as file:
        file.write(f"{tick_len * max_mins}")
        print("Creating ticks_left")
except FileExistsError:
    try:
        ticks_left = int(open(f"{root_dir}/ticks_left").read().strip())
    except ValueError:
        print("Supplied value in ticks_left is invalid")
        raise ValueError

try:
    with open(f"{root_dir}/ticks_used", 'x') as file:
        file.write("0")
        print("Creating ticks_used")
except FileExistsError:
    try:
        ticks_used = int(open(f"{root_dir}/ticks_used").read().strip())
    except ValueError:
        print("Supplied value in ticks_used is invalid")
        raise ValueError
    
try:
    with open(f"{root_dir}/user", 'x') as file:
        file.write(user)
        print("Creating user")
except FileExistsError:
    user = open(f"{root_dir}/user").read().strip()
    if user == "":
        print("Username is empty")
        raise Exception
    
max_ticks = round(max_mins * 60 / tick_len)

while True:
    ticks_left = int(open(f"{root_dir}/ticks_left").read().strip())
    print("Ticks left:", ticks_left)
    current_day = date.today()
    try:
        last_used = date.fromisoformat(open(f"{root_dir}/date").read().strip())
    except Exception:
        last_used = current_day

    if current_day > last_used:
        open(f"{root_dir}/date", "w").write(current_day.isoformat())
        ticks_left = round(max_mins * 60 / tick_len)
        open(f"{root_dir}/ticks_left", "w").write(f"{ticks_left}")
        open(f"{root_dir}/ticks_used", "w").write("0")
        
    if os.popen("users").read().find(user) != -1:
        print("User is logged in; decreasing tick count")
        ticks_left -= 1
        ticks_used += 1
        open(f"{root_dir}/ticks_used", "w").write(f"{ticks_used}")
        open(f"{root_dir}/ticks_left", "w").write(f"{ticks_left}")
        if ticks_left <= 0:
            id = os.popen(f"pgrep -o -u {user}").read()
            os.system(f"kill -9 {id}")
    time.sleep(tick_len)
