import json,re,time,urllib.request,html,os,sys
urls=json.load(open('items_urls.json'))
import sys
K,N=int(sys.argv[1]),int(sys.argv[2])
out='prices_retry_%d.tsv'%K
done=set()
import glob
for fn in glob.glob('prices*.tsv'):
    if os.path.exists(fn): done|={l.split('\t')[0] for l in open(fn)}
f=open(out,'a')
def money(cell):
    g=re.search(r"cur_g'>(\d+)<",cell); s=re.search(r"cur_s'>(\d+)<",cell); c=re.search(r"cur_c'>(\d+)<",cell)
    # value before the '(' only
    return None
def parse_cell(cell):
    main=cell.split('(')[0]
    v=0
    for cls,mul in (('g',10000),('s',100),('c',1)):
        m=re.search(r"cur_%s'>(\d+)<"%cls,main)
        if m: v+=int(m.group(1))*mul
    dev=0
    if '(' in cell:
        d=cell.split('(',1)[1]
        for cls,mul in (('g',10000),('s',100),('c',1)):
            m=re.search(r"cur_%s'>(\d+)<"%cls,d)
            if m: dev+=int(m.group(1))*mul
    return v,dev
for n,(iid,(ts,orig)) in enumerate(sorted(urls.items())):
    if n%N!=K or iid in done: continue
    u='https://web.archive.org/web/%sid_/%s'%(ts,orig)
    for attempt in range(3):
        try:
            t=urllib.request.urlopen(u,timeout=40).read().decode('utf-8','ignore'); break
        except Exception as e:
            t=None; time.sleep(10*(attempt+1))
    if not t: f.write(f"{iid}\tERR\n"); f.flush(); continue
    name=re.search(r'<title>\s*WoW Auction House Prices /\s*(.*?),\s*(EU|US)',t,re.S)
    name=html.unescape(name.group(1).strip()) if name else ''
    def row(title):
        m=re.search(re.escape(title)+r'.*?</td>\s*<td>(.*?)</td>\s*<td>(.*?)</td>',t,re.S)
        return m.groups() if m else (None,None)
    med=row('Median Market Price (StdDev)')
    posted=row('Average Posted per Day'); sold=row('Estimated Sold per Day')
    if med[1] is None:
        f.write(f"{iid}\tNODATA\t{name}\t{ts}\n"); f.flush(); time.sleep(1); continue
    rm,rd=parse_cell(med[1]); lm,ld=parse_cell(med[0])
    clean=lambda x: re.sub(r'<[^>]+>|&nbsp','',x or '').strip()
    f.write("\t".join(map(str,[iid,'OK',name,ts,rm,rd,clean(posted[1]),clean(sold[1]),lm,clean(sold[0])]))+"\n"); f.flush()
    time.sleep(3)
print('fini')
