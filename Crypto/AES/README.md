<h1 align="center">IMPLEMENTATIONS OF AES ALGORITHMS</h1>

<h4>Block of AES state or key</h4>
Example: <b>3243f6a8 885a308d 313198a2 e0370734</b> data in hex is a block:

<table>
<tbody>
  <tr>
    <td>32</td>
    <td>88</td>
    <td>31</td>
    <td>e0</td>
  </tr>
  <tr>
    <td>43</td>
    <td>5a</td>
    <td>31</td>
    <td>37</td>
  </tr>
  <tr>
    <td>f6</td>
    <td>30</td>
    <td>98</td>
    <td>07</td>
  </tr>
  <tr>
    <td>a8</td>
    <td>8d</td>
    <td>a2</td>
    <td>34</td>
  </tr>
</tbody>
</table>
and w0 = <b>3243f6a8</b>, w1 = <b>885a308d</b>, w2 = <b>313198a2</b>, w3 = <b>e0370734</b> so this block can be display as:
<table>
<tbody>
  <tr>
    <td>word 0</td>
    <td>word 1</td>
    <td>word 2</td>
    <td>word 3</td>
  </tr>
</tbody>
</table>
and can also be display as this block of byte with indexes:
<table>
<tbody>
  <tr>
    <td>byte 15</td>
    <td>byte 11</td>
    <td>byte 7</td>
    <td>byte 3</td>
  </tr>
  <tr>
    <td>byte 14</td>
    <td>byte 10</td>
    <td>byte 6</td>
    <td>byte 2</td>
  </tr>
  <tr>
    <td>byte 13</td>
    <td>byte 9</td>
    <td>byte 5</td>
    <td>byte 1</td>
  </tr>
  <tr>
    <td>byte 12</td>
    <td>byte 8</td>
    <td>byte 4</td>
    <td>byte 0</td>
  </tr>
</tbody>
</table>
so that if we need to get the row with index = row_index of the block:
<table>
<tbody>
  <tr>
    <td>byte 13</td>
    <td>byte 9</td>
    <td>byte 5</td>
    <td>byte 1</td>
  </tr>
</tbody>
</table>
row_data

= join all block_of_bytes(col_index * 4 + row_index) for col_index from 0 to 3

= join all block_of_words(word_index)(row_index) for word_index from 0 to 3