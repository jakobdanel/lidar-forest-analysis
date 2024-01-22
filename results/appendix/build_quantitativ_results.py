
def write_md_header(content, size):
    return "#"*size+" "+content+"\n\n"


def write_test_block(test_name, test_long_name, distribution_name, is_specie = True, specie_name = None):
    if is_specie:
        specie_name = "specie"
        col = "specie" 
        data = "data"
    else:
        col = "area"
        data = "specie"
        
    if test_name == "kld":
        result_var = f"kld_results_{specie_name}"
        result_code = f"{result_var} <- lfa::lfa_run_test_asymmetric({data},value_column,\"{col}\",lfa::lfa_kld_from_vec)"
    elif test_name == "jsd":
        result_var = f"jsd_results_{specie_name}"
        result_code = f"{result_var} <- lfa::lfa_run_test_symmetric({data},value_column,\"{col}\",lfa::lfa_jsd_from_vec)"
    
    
    if is_specie:
        return f"""```{{r}}
#| warning: false
#| code-fold: true
#| label: tbl-{distribution_name}-{test_name}_specie
#| tbl-cap: "{test_long_name} between the researched species Beech, Oak, Pine and Spruce for the atrribute {distribution_name}" 
{result_code}
lfa::lfa_generate_result_table_tests({result_var},"{test_long_name} between species")
```



```{{r}}
#| warning: false
colMeans({result_var}, na.rm = TRUE) |> mean()
```
"""
    else:
        return f"""```{{r}}
#| warning: false
#| code-fold: true
#| label: tbl-{distribution_name}-{test_name}-{specie_name}
#| tbl-cap: "{test_long_name} between the researched areas which have the dominante specie {specie_name} for the atrribute {distribution_name}"
specie <- data[data$specie=="{specie_name}",]
{result_code}
lfa::lfa_generate_result_table_tests({result_var},"{test_long_name} between areas with {specie_name}")
```



```{{r}}
#| warning: false
colMeans({result_var}, na.rm = TRUE) |> mean()
```
"""








def build_quantitativ_results(distribution_name = "detections",distribution_name_long = "DEFAULT",value_column = '"Z"', header_size = 3, preprocessing = "data <- lfa::lfa_get_detections()"):
    return f"""{write_md_header(distribution_name_long,header_size)}
```{{r}}
#| warning: false
#| code-fold: true
{preprocessing}
value_column <- {value_column}
```



{write_md_header("Kullback-Leibler-Divergence",header_size+1)}

{write_test_block("kld","Kullback-Leibler-Divergence",distribution_name)}



{write_test_block("kld","Kullback-Leibler-Divergence",distribution_name,False,"beech")}



{write_test_block("kld","Kullback-Leibler-Divergence",distribution_name,False,"oak")}



{write_test_block("kld","Kullback-Leibler-Divergence",distribution_name,False,"pine")}



{write_test_block("kld","Kullback-Leibler-Divergence",distribution_name,False,"spruce")}



{write_md_header("Jensen-Shannon Divergence",header_size+1)}

{write_test_block("jsd","Jensen-Shannon Divergence",distribution_name)}



{write_test_block("jsd","Jensen-Shannon Divergence",distribution_name,False,"beech")}



{write_test_block("jsd","Jensen-Shannon Divergence",distribution_name,False,"oak")}



{write_test_block("jsd","Jensen-Shannon Divergence",distribution_name,False,"pine")}



{write_test_block("jsd","Jensen-Shannon Divergence",distribution_name,False,"spruce")}
"""

def write_file(destination, content):
    with open(destination, "w") as file:
        file.write(content)
    print(f"File {destination} written")
    
def main():
    content = build_quantitativ_results("z-values", "Distribution of Z-Values", '"Z"', header_size=3)
    write_file("z_values.qmd", content)
    
if __name__ == "__main__":
    main()