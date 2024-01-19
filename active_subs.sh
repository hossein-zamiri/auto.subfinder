active_subs () {
        cd $1
        wget https://wordlists-cdn.assetnote.io/data/manual/2m-subdomains.txt
        wget https://wordlists-cdn.assetnote.io/data/manual/best-dns-wordlist.txt
        cat 2m-subdomains.txt best-dns-wordlist.txt | sort -u >> merged-dns.txt
        rm 2m-subdomains.txt best-dns-wordlist.txt
        shuffledns -w merged-dns.txt -r ~/.resolvers -d $1 -silent | anew resolved | notify -bulk
        shuffledns -w ~/wordlists/4_all.txt -r ~/.resolvers -d $1 -silent | anew resolved | notify -bulk
        rm merged-dns.txt
        curl -s https://raw.githubusercontent.com/infosec-au/altdns/master/words.txt -o altdns-words.txt
        curl -s https://raw.githubusercontent.com/ProjectAnte/dnsgen/master/dnsgen/words.txt -o dnsgen-words.txt
        cat altdns-words.txt dnsgen-words.txt | sort -u >> merged-dns.txt
        cat resolved | dnsgen -w merged-dns.txt - >> dnsgen.words
        altdns -i resolved -w merged-dns.txt -o altdns.words
        cat altdns.words dnsgen.words | sort -u >> dynamic.words
        shuffledns -l dynamic.words -d $1 -r ~/.resolvers -silent | anew resolved | notify -bulk
        rm dynamic.words merged-dns.txt altdns-words.txt dnsgen-words.txt dnsgen.words altdns.words
        echo "done"
        cd ../
}
