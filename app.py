import streamlit as st

st.title("Simple Streamlit App on AWS App Runner")
st.write("Hello! This is a simple Streamlit application deployed using AWS App Runner.")

name = st.text_input("Enter your name:")
if name:
    st.write(f"Hello, {name}! Welcome to our Streamlit app.")

st.write("This app is running on AWS App Runner!")