#!/bin/bash
# Downloads and web-optimizes all site images. Run from site/assets/. Needs ImageMagick (convert) or macOS sips.
set -e
declare -A IMGS=(
[hero-crew]="1800 hf_20260818_014854_606699dc-4749-4675-8857-435e8724a112"
[pain-missed-call]="1200 hf_20260818_015003_458f7c05-11ed-4184-8992-7b35f440d632"
[pain-quiet-office]="1200 hf_20260818_014854_d7bc7025-9c27-4ac1-ada7-7583d8c012c8"
[storm]="1500 hf_20260818_014854_e1f1597a-cb80-4589-87aa-069173d6cd5b"
[ad-team]="1500 hf_20260818_014854_e1245631-3969-4cd1-a53f-57e570332e08"
[craft-hands]="1000 hf_20260818_014854_76bcf9c5-5865-449c-8747-a28d04c64d19"
[handshake]="1200 hf_20260818_014854_52aef2b6-c98c-4cf9-b5e9-a05616d845aa"
[booked-calendar]="1000 hf_20260818_014854_9b60c9c0-b36a-4f4e-996c-f5d55541aa72"
[aerial]="1500 hf_20260818_014854_d3d45b72-dd01-4efd-9723-417ecd70d6cf"
[review]="1000 hf_20260818_014854_b101acf7-32bc-484c-87a3-dbd3465be272"
[trucks-dawn]="1500 hf_20260818_014854_b8cc3541-e3d6-4ac3-a618-a0f915c60ebf"
[before-after]="1800 hf_20260818_015003_33828aac-3f7a-42ab-a2ae-37e61c837aeb"
)
BASE="https://d8j0ntlcm91z4.cloudfront.net/user_33wxgpbGivDqYMQGx6Mulkyq2fE"
for name in "${!IMGS[@]}"; do
  read -r width id <<< "${IMGS[$name]}"
  echo "-> $name ($width px)"
  curl -sS -o "$name.png" "$BASE/$id.png"
  if command -v convert >/dev/null; then
    convert "$name.png" -resize "${width}x" -quality 74 -strip "$name.jpg"
  else
    sips -Z "$width" -s format jpeg -s formatOptions 74 "$name.png" --out "$name.jpg" >/dev/null
  fi
  rm "$name.png"
done
echo "Done. $(ls -1 *.jpg | wc -l) images ready."
