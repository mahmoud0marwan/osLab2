
all: file antivirus restore 

file:
	@mkdir -p malicious
antivirus:
	@./antivirusd.sh watched malicious 5
restore:
	@./restore.sh watched malicious
