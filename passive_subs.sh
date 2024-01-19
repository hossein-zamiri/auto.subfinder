passive_subs () {
        mkdir $1
        cd $1
        echo "subfinder is running"
        subfinder -d $1 -all -silent | anew $1.subs
        echo "\n"
        echo "crtsh is running"
        crtsh $1 | grep -v "*" | sort -u | anew $1.subs
        echo "\n"
        echo "abuseip is running"
        curl -s -H "$2" -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/115.0" https://www.abuseipdb.com/whois/$1 | grep -E '<li>\w.*</li>' | sed -E 's/<\/?li>//g' | while read r
        do
                echo $r.$1 | sort -u | anew $1.subs
        done
        echo "\n"
        echo "sourcegraph is rauning"
        github_scan $1 | anew $1.subs
        echo "\n"
        echo "amass is running"
        amass enum -passive -d $1
        amass db -names -d $1 | anew $1.subs
        echo "chaos is running"
        chaos -d $1 | anew $1.subs
        echo "assetfinder is running"
        assetfinder $1 | anew $1.subs
        shuffledns -l $1.subs -r ~/.resolvers -d $1 -silent | anew resolved | notify -bulk
}
