import gradio as gr


def greet(name):
    return "Hello " + name + "!"


demo = gr.Interface(fn=greet, inputs="text", outputs="text")

if __name__ == "__main__":
    """
    本地运行：python app.py
    """
    demo.launch(show_api=False)

