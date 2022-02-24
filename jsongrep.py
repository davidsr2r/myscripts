import glob
import json
import sys
if __name__ == "__main__":
    target_str = str(sys.argv[1])
    patt_str = str(sys.argv[2])      # E.g. *202008*.json
    print(f"File Search Pattern = {patt_str}")
    for fname in glob.glob(f'{patt_str}'):
        # print(f"Searching {fname}...")
        with open(fname, 'r') as jsonfile:
            obj = json.load(jsonfile)
            if "errors" in obj:
                print(f"Found error file with name {fname}. Contents: {obj}")
                continue
            if "raw" in obj:
                for record in obj["raw"]:
                    record_lst = [str(line) for line in record]
                    if target_str in record_lst:
                        print(f"Found in {fname}:")
                        print("\t" + ",".join(record_lst))
            # else:
            #     print(f"Could not access 'raw' in obj {fname}")
            #     print(f"File Contents: `{obj}`")

