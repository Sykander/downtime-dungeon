# Development
# 0df096b5-a5ec-48ca-88bd-b310061c5b79
# Production
# 8f86e5dd-2f5b-4948-85bf-19531c936e45

def merge_dicts(dict1, dict2):
    # Get all unique keys from both dictionaries
    all_keys = set(dict1.keys()).union(dict2.keys())
    
    # Create the merged dictionary
    merged_dict = {key: (dict1.get(key, None), dict2.get(key, None)) for key in all_keys}
    
    return merged_dict