from datetime import datetime

def generate_text():
    current_time = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    text = f"Hello, this is a simple text generated on {current_time}."
    print(text)

if __name__ == "__main__":
    generate_text()
