import os

# Retrieve the name from the environment variable
# The `os.getenv` function is used to retrieve the value of the environment variable "USER_NAME"
# If the environment variable is not set or does not exist, the second argument "John" is used as the default value
name = os.getenv("USER_NAME", "John")

# Greet the user
# The `print` function is used to display a greeting message to the user
# The message includes the value of the `name` variable obtained from the environment variable or the default value
print(f"Hello, {name}! Welcome to the Matrix!")
