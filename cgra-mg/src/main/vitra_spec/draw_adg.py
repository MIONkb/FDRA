import json
import argparse
from graphviz import Digraph

def get_instances(instances, id):
    for instance in instances:
        if(instance["id"] == id):
            return instance

def parse_adg_and_generate_dot(adg_file, output_dot_file, enable_pos=False):
    # 读取 adg.json 文件
    with open(adg_file, 'r') as f:
        adg_data = json.load(f)

    # 打开输出文件
    with open(output_dot_file + ".dot", "w") as dot_file:
        # 写入 DOT 文件头
        dot_file.write("digraph ADG {\n")
        dot_file.write("layout=neato; \noverlap=false; \nsplines=true;\n")

        samex = dict[int, list()]()

        tile_col = adg_data.get("tile_num_col", 8)

        # 遍历实例，提取 GPE 和 GIB 节点
        instances = adg_data.get("instances", [])
        for instance in instances:
            if instance["type"] == "this" :
                continue

            node_id = f'{instance["type"]}{instance["id"]}'
            node_type = instance["type"]
            tile, x, y = instance.get("tile", 0), instance.get("x", 0), instance.get("y", 0)

            pos = f'{(tile) * tile_col * 2 + y * 2}, {x * 2}!'

            if(x not in samex.keys()):
                samex[x] = []

            samex[x].append(node_id)

            # 如果是 GPE，附加支持的操作信息
            if node_type == "GPE":
                module_id = instance["module_id"]
                supported_ops = []
                for submodule in adg_data.get("sub_modules", []):
                    if submodule.get("id") == module_id:
                        # 返回 operations 字段
                        supported_ops = submodule["attributes"]["operations"]
                label = f'{node_id}({tile, x, y})'
                Ops =  f'{", ".join(supported_ops)}'
                
                dot_file.write(f'{node_id}[label = "{label}" , operations= "{Ops}" color = black, shape="box"')
                if(enable_pos):
                    dot_file.write(f', pos="{pos}"')
                dot_file.write(f'];\n')

            elif node_type == "GIB":
                label = f'{node_id}({tile, x, y})'
                dot_file.write(f'{node_id}[label = "{label}", color = blue, shape="ellipse"')
                if(enable_pos):
                    dot_file.write(f', pos="{pos}"')
                dot_file.write(f'];\n')

            elif node_type == "IOB":
                label = f'{node_id}({tile, x, y})'
                dot_file.write(f'{node_id}[label = "{label}", color = green, shape="diamond"')
                if(enable_pos):
                    dot_file.write(f', pos="{pos}"')
                dot_file.write(f'];\n')
        
        dot_file.write(f'\n')
        
        # for x in samex.keys():
        #     # { rank=same; IOB1; IOB2; }  
        #     dot_file.write('{ rank=same; ')
        #     dot_file.write(", ".join(samex[x]))
        #     dot_file.write('}\n')

        # 遍历连接关系，绘制边
        connections = adg_data.get("connections", {})
        connection_format = adg_data.get("connection_format", [])
        for edgeidx, edge in connections.items():
            src_id = edge[connection_format.index("src_id")]
            src_type = edge[connection_format.index("src_type")]
            src_out_idx = edge[connection_format.index("src_out_idx")]
            dst_id = edge[connection_format.index("dst_id")]
            dst_type = edge[connection_format.index("dst_type")]
            dst_in_idx = edge[connection_format.index("dst_in_idx")]

            # 构造节点名称
            src_node = f"{src_type}{src_id}"
            dest_node = f"{dst_type}{dst_id}"
            
            # assert
            src_ins = get_instances(instances, src_id)
            dst_ins = get_instances(instances, dst_id)
            assert(src_ins["type"] == src_type)
            assert(dst_ins["type"] == dst_type)
                

            # 写入边信息
            dot_file.write(f'{src_node}->{dest_node}[color = gray80];\n')

        # 写入 DOT 文件尾
        dot_file.write("}\n")

    print(f"DOT file saved to {output_dot_file}.dot")

if __name__ == "__main__":
    # 使用 argparse 解析命令行参数
    parser = argparse.ArgumentParser(description="Parse ADG JSON and generate a DOT graph.")
    parser.add_argument(
        "adg_file",
        nargs="?",
        default="/home/jhlou/chipyard/generators/fdra/cgra-mg/src/main/vitra_spec/vitra_cgra_adg.json",
        help="Path to the input ADG JSON file (default: adg.json)."
    )
    parser.add_argument(
        "output_dot_file",
        nargs="?",
        default="/home/jhlou/chipyard/generators/fdra/cgra-mg/src/main/vitra_spec/adg",
        help="Path to the output DOT file (without extension, default: adg.png)."
    )
    args = parser.parse_args()

    # 调用函数生成图
    parse_adg_and_generate_dot(args.adg_file, args.output_dot_file, enable_pos=True)