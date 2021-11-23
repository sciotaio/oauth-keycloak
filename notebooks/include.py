import json

PWD="**********"

def json_pretty_print(str):
    try:
        data = json.loads(str)
        print(json.dumps(data, indent=4, sort_keys=True))
    except e:
        print("Could not pretty print ({})\n{}".format(e, str))
        
globals()['json_pretty_print']=json_pretty_print