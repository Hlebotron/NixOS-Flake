#! /bin/python3

from datetime import date
import time
import os
root_dir = "/opt/limit"

# max_mins_r = open(f"{root_dir}/max_mins", "r")
# max_mins_w = open(f"{root_dir}/max_mins", "w")

# date_r = open(f"{root_dir}/date", "r")
# date_w = open(f"{root_dir}/date", "w")

# ticks_left_r = open(f"{root_dir}/ticks_left", "r")
# ticks_left_w = open(f"{root_dir}/ticks_left", "w")

# ticks_used_r = open(f"{root_dir}/ticks_used", "r")
# ticks_used_w = open(f"{root_dir}/ticks_used", "w")

# tick_len_r = open(f"{root_dir}/tick_length_secs", "r")
# tick_len_w = open(f"{root_dir}/tick_length_secs", "w")

# user_r = open(f"{root_dir}/user", "r")
# user_w = open(f"{root_dir}/user", "w")


max_mins = 15
user = "maxim"
tick_len = 10
ticks_used = 0

try:
    with open(f"{root_dir}/tick_length_secs", 'x') as file:
        print("Creating file tick_length_secs")
        file.write(f"{tick_len}")
except FileExistsError:
    tick_len = int(open(f"{root_dir}/tick_length_secs").read())

try:
    with open(f"{root_dir}/max_mins", 'x') as file:
        print("Creating file max_mins")
        file.write(f"{max_mins}")
except FileExistsError:
    max_mins = int(open(f"{root_dir}/max_mins").read())

try:
    with open(f"{root_dir}/date", 'x') as file:
        print("Creating file date")
        file.write(date.today().isoformat())
except FileExistsError:
    pass

try:
    with open(f"{root_dir}/ticks_left", 'x') as file:
        print("Creating ticks_left")
        file.write(f"{tick_len * max_mins}")
except FileExistsError:
    ticks_left = int(open(f"{root_dir}/ticks_left").read())

try:
    with open(f"{root_dir}/ticks_used", 'x') as file:
        print("Creating ticks_used")
        file.write("0")
except FileExistsError:
    ticks_used = int(open(f"{root_dir}/ticks_used").read())
try:
    with open(f"{root_dir}/user", 'x') as file:
        print("Creating user")
        file.write(user)
except FileExistsError:
    user = open(f"{root_dir}/user").read().strip()
    print("User:", user)
    # current_day1 = open(f"{root_dir}/date").read()
max_ticks = round(max_mins * 60 / tick_len)

while True:
    print("pog")
    ticks_left = int(open(f"{root_dir}/ticks_left").read())
    print(ticks_left)
    last_used = date.fromisoformat(open(f"{root_dir}/date").read())
    current_day = date.today()
    if current_day > last_used:
        open(f"{root_dir}/date", "w").write(f"{current_day}")
        ticks_left = round(max_mins * 60 / tick_len)
        open(f"{root_dir}/ticks_left", "w").write(f"{ticks_left}")
        open(f"{root_dir}/ticks_used", "w").write("0")
        
    print("User:", user)
    print("Found:", os.popen("users").read().find(user))
    if os.popen("users").read().find(user) != -1:
        print("Present")
        ticks_left -= 1
        ticks_used += 1
        open(f"{root_dir}/ticks_used", "w").write(f"{ticks_used}")
        open(f"{root_dir}/ticks_left", "w").write(f"{ticks_left}")
        if ticks_left <= 0:
            id = os.popen(f"pgrep -o -u {user}").read()
            os.system(f"kill -9 {id}")
    time.sleep(tick_len)
