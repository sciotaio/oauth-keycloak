import json

def json_pretty_print(str):
    try:
        data = json.loads(str)
        print(json.dumps(data, indent=4, sort_keys=True))
    except Exception as e:
        print("Could not pretty print ({})\n{}".format(e, str))
        
globals()['json_pretty_print']=json_pretty_print