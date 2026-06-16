TARGET = helloworld

SOURCE = helloworld.asm

FORMAT = elf64

all: $(TARGET)

$(TARGET):
	nasm -f $(FORMAT) $(SOURCE) -o $(TARGET).o
	ld $(TARGET).o -o $(TARGET)

run: $(TARGET)
	./$(TARGET)

clean:
	rm -f $(TARGET).o $(TARGET)

