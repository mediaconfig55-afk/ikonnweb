$path = "c:\Users\Ghost\Desktop\icon\index.html"
$content = Get-Content $path -Raw

$newBlock = @"
<!-- Products Showcase Redirect -->
        <section id="products" class="products bg-light py-5">
            <div class="container text-center py-5">
                <header class="section-header">
                    <p class="section-subtitle">TÜM ÜRÜNLERİMİZ</p>
                    <h2 class="section-title">Uzman İklimlendirme Çözümleri</h2>
                    <p class="section-desc mb-4">Gelişmiş teknoloji ile donatılmış yeni nesil ısı pompası ve klima sistemlerimizi detaylıca incelemek için ürün kataloğumuza gidin.</p>
                    <div class="heading-line mx-auto mb-4"></div>
                </header>
                <div class="mt-4 pb-5">
                    <a href="urunler.html" class="btn btn-primary btn-lg"><i class="fa-solid fa-layer-group"></i> Ürünleri İncele</a>
                </div>
            </div>
        </section>
"@

# Regex pattern down to the About section
$pattern = '(?s)<!-- Products Showcase -->.*?<!-- About / Energy Efficiency Section -->'
$replacement = "$newBlock`n`n        <!-- About / Energy Efficiency Section -->"

$newContent = $content -replace $pattern, $replacement
[IO.File]::WriteAllText($path, $newContent, [System.Text.Encoding]::UTF8)
Write-Host "Replaced products section in index.html"
