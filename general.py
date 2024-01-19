import subprocess


abuse_ip_session = input("enter your abuse_ip_session: ")
s = []

with open('targets.txt', 'r') as file:
    for line in file:
        s.append(line.strip('\n'))  
for i in s:
    target=i
    print("passive recon")

    command = f'zsh -c "source ~/.zshrc && passive_subs {target} \'Cookie: {abuse_ip_session}\'"'

    try:
        subprocess.run(command, shell=True, check=True)
    except subprocess.CalledProcessError as e:
        print("Error executing command:", e)

    print("active recon")

    command = f'zsh -c " source ~/.zshrc && active_subs {target}"'

    try:
        subprocess.run(command, shell=True, check=True)
    except subprocess.CalledProcessError as e:
        print("Error executing command:", e)
