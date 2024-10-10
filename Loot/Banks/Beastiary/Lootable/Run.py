import pandas as pd

webpage_url = "https://en.wikipedia.org/wiki/List_of_animal_names"
webpage_tables = pd.read_html(webpage_url)
heads_df = webpage_tables[2]
print(heads_df)
