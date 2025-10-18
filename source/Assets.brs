function Assets() as object
    _assets = [
        {
            asset: {
                manifest: "http://qthttp.apple.com.edgesuite.net/1010qwoeiuryfg/sl.m3u8",
                transport: "Hls"
            },
            metadata: {
                assetTitle: "Apple Stream",
                text: "Apple Stream",
                categories: ["NoDRM"]
            }
        },
        {
            asset: {
                manifest: "http://cdnbakmi.kaltura.com/p/243342/sp/24334200/playManifest/entryId/0_uka1msg4/flavorIds/1_vqhfu6uy,1_80sohj7p/format/applehttp/protocol/http/a.m3u8",
                transport: "Hls"
            },
            metadata: {
                assetTitle: "Folgers",
                text: "Folgers",
                categories: ["NoDRM"]
            }
        }
    ]
    return _assets
end function
