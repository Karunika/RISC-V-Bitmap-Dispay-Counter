from PIL import Image, ImageFont, ImageDraw

background_color = (0, 0, 0)  # White
foreground_fill = (255, 255, 255)

names = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]

cols = 32

for i in range(10):
    char = str(i)

    image = Image.new('RGB', (32, 64), background_color)

    draw = ImageDraw.Draw(image)
    font = ImageFont.truetype("/System/Library/Fonts/Monaco.ttf", 64-8)
    draw.text((0, 0), char, font=font, fill=foreground_fill)


    pixels = list(image.getdata())

    text_str = f'_{names[i]}: .word \n'
    for j, pixel in enumerate(pixels):
        text_str += "0xffffff" if pixel[0] > 128 else "0x000000"
        text_str += ", "
        if (j+1)%cols == 0:
            text_str += "\n"

    print(len(pixels))

    with open(f'bits/{char}_bits.asm', 'w') as file:
        file.write(text_str)
