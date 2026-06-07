$products = @{
    "f110" = "https://www.nibe.com.tr/product/nibe-f110-kullanim-sicak-suyu-isi-pompalari/"
    "mtwh21" = "https://www.nibe.com.tr/product/nibe-mt-wh21-kullanim-sicak-suyu-isi-pompasi/"
    "split" = "https://www.nibe.com.tr/product/nibe-split-isi-pompasi/"
    "f2120" = "https://www.nibe.com.tr/product/nibe-f2120-monoblok-isi-pompasi-65-c/"
    "f2040" = "https://www.nibe.com.tr/product/nibe-f2040-monoblok-isi-pompasi/"
    "onoff" = "https://www.nibe.com.tr/urunler/isi-pompasi/toprak-kaynakli-isi-pompasi/on-off-yer-kaynakli-toprak-su-isi-pompasi/"
    "inverter" = "https://www.nibe.com.tr/urunler/isi-pompasi/toprak-kaynakli-isi-pompasi/inverter-yer-kaynakli-toprak-su-isi-pompasi/"
    "fseries" = "https://www.nibe.com.tr/product/egzos-kaynakli-isi-pompalari/"
}

foreach ($key in $products.Keys) {
    try {
        $response = Invoke-WebRequest -Uri $products[$key]
        $imgUrls = $response.Images | Select-Object -ExpandProperty src | Where-Object { $_ -match "\.jpg|\.png" -and $_ -match "uploads" -and $_ -notmatch "Nibe.png|UntesLogo|indir.png|footer|header|menu|icon" } | Select-Object -Unique
        
        # Prefer specific terms in image URL (e.g. product name or 600x600)
        $bestMatch = $imgUrls | Where-Object { $_ -match "$key|600x600|pompa" } | Select-Object -First 1
        
        if (-not $bestMatch -and $imgUrls.Count -gt 0) {
            $bestMatch = $imgUrls[0]
        }

        if ($bestMatch) {
            # if URL starts with //
            if ($bestMatch -match "^//") {
                $bestMatch = "https:$bestMatch"
            }
            # if relative
            elseif ($bestMatch -match "^/") {
                $bestMatch = "https://www.nibe.com.tr$bestMatch"
            }
            
            Invoke-WebRequest -Uri $bestMatch -OutFile "c:\Users\Ghost\Desktop\icon\assets\img\nibe_$key.jpg"
            Write-Host "Downloaded $key -> $bestMatch"
        } else {
            Write-Host "No image found for $key"
        }
    } catch {
        Write-Host "Failed for $key - $_"
    }
}
