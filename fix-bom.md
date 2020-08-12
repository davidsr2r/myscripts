# Check BOM
`file Tools/ToolsAnalysis/Bookings/BookingRecords/*.cs`

# Fix BOM
**Using the `fix-bom.sh` script**: `sh -c "fix-bom.sh Tools/ToolsAnalysis/Bookings/BookingRecords/OmioBooking.cs"`
**Taking Files simply from BookingRecords**: `find -L Tools/ToolsAnalysis/Bookings/BookingRecords -type f -name '*.cs' | xargs sed -i '1s/^/\xef\xbb\xbf/'`
**Taking all matching files from the entire repo**: `find . -type f -name '*.cs'` 
FYI the `sed` pattern is `'s/<old>/<new>/g'`, so `sed -i '1s/^/\xef\xbb\xbf/'` takes `^` and replaces it with `\xef\xbb\xbf`. I still don't know what the `1` does.
