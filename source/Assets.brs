function Assets() as Object
    _assets = [
        {
            asset: {
                manifest: "http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8",
                transport: "Hls"
            },
            metadata: {
                assetTitle: "Bip Bop",
                text: "Bip Bop",
                categories: ["NoDRM"]
            }
        },
        {
            asset: {
                manifest: "https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8",
                transport: "Hls"
            },
            metadata: {
                assetTitle: "Tears of Steel",
                text: "Tears of Steel",
                categories: ["NoDRM"]
            }
        }
    ]
    return _assets
end function
