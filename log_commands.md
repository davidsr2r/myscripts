# Retrieving Logs
**Get All 2020 Request Logs**: `robocopy \\SWAN\ProductionServerLogs\Cache\2020\ D:\Logs\fromserver\Cache\2020\ *Requests* /MIR`

**Get 2020 Exit Logs**: `robocopy \\SWAN\ProductionServerLogs\Cache\2020\ D:\Logs\fromserver\Cache\2020\ Exit.* /MIR`

**Get HumanRequests Logs**: `robocopy \\SWAN\ProductionServerLogs\Cache\2020\ D:\Logs\fromserver\Cache\2020\ HumanRequests* /MIR`

**Get UserRequests Logs**: `robocopy \\SWAN\ProductionServerLogs\Cache\2020\ D:\Logs\fromserver\Cache\2020\ UserRequests* /MIR`

## Log Searching

**Looking for Specific Exit Point from Omio Redirect in Exit Logs**: `cd /d/Logs/fromServer/Cache/2020/05/06` then `for Line in $(zcat Exit.* | grep www.omio.com | grep 'label=' | grep 'ep01%253Au%253Aa%253Ac%253Ae' | cut -f 22-); do echo $(urldecode $(urldecode $Line)); done >> ~/tmp/omio_bad_exit_points.txt`
`'ep01%253Au%253Aa%253Ac%253Ae'` is simply `'ep01:u:a:c:e'` URL encoded twice.
`urldecode` is defined: `function urldecode() { : "${*//+/ }"; echo -e "${_//%/\\x}"; }`



**Search for a request id in all log files in a folder**: `zgrep '139-20200120-101916-5256604' 01/20/*.tsv.gz | tee -a ~/tmp/missing_ids_samedate.tsv`   (`>>` instead of `tee -a` if we want to simply append and not view the output in the console). Output saved in `~/tmp/missing_ids_samedate.tsv`
**For loop**: After manipulating a bunch of request ids and after `cd /mnt/d/Logs/fromserver/Cache/2020`, you can place the list of request ids into this command: `for i in {142-20200120-220953-7682752,141-20200120-201549-7770261,122-20200120-095533-1405955,141-20200120-194221-5275640,143-20200120-174326-6134115,122-20200120-203158-3437119,122-20200120-195054-5955716,143-20200120-083734-4512545,142-20200120-194707-6790695,124-20200120-205109-3838542}; do zgrep "$i" 01/20/*.tsv.gz | tee -a ~/tmp/missing_ids_samedate.tsv; done`

## Parsing Booking.Com User Booking Json Files

**reservation_ids for IsUnknown rows (pulled from Visual Studio)**
```
		[0]	"3372062636"	string
		[1]	"3116571940"	string
```
**Horrible script to look at the affiliate_label for the reservation_ids above**

```bash
for X in Data.Analytics.Raw/bookingcomjson/BookingComApi-2020041* ; do
    cat $X | python -m json.tool | egrep '3372062636|3116571940|3116561211|3116519021|3007104731|3687075177|3956974941|affiliate_label'
done | egrep -B 1 'reservation_id'
```

Results:
```
            "affiliate_label": "from_conf_1",
            "reservation_id": 3372062636,
--
            "affiliate_label": "postbooking_canxemail",
            "reservation_id": 3116571940,
--
            "affiliate_label": "affnetawin-index_pub-214459_site-g8223403826720397495-a8319513684895729659_pname-Honey Science Corporation_plc-_ts-_clkid-6776_1586821305_c40454a2bffc29040c32698fbc93f839",
            "reservation_id": 3116561211,
```
**Normal reservation_ids look like**:
`cat Data.Analytics.Raw/bookingcomjson/BookingComApi-20200414-20200415135426-0.json | python -m json.tool | grep affiliate_label | head`
Results"
```
            "affiliate_label": "r2r05,RUXXX20200129000000000lsgd,ep01:f:a:b:b,,1d:2,202001290000,36-20200129-110942-4873532",
            "affiliate_label": "r2r05,AUXXX20200229000000000ufgd,ep01:e:a:b:b,,1d:2,202002290000,143-20200229-050222-6876370",
...
```
