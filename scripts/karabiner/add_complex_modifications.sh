# !/bin/zsh

# Add karabiner_fake_vim_rule.json to ~/.config/karabiner/assets/complex_modifications/
if [ ! -f ~/.config/karabiner/assets/complex_modifications/karabiner_fake_vim_rule.json ]; then
  echo "Adding complex_modifications to ~/.config/karabiner/"
  mkdir -p ~/.config/karabiner/assets/complex_modifications
  ln karabiner_fake_vim_rule.json ~/.config/karabiner/assets/complex_modifications/karabiner_fake_vim_rule.json
  echo "\033[32m✅SUCCESS:\033[0m karabiner_fake_vim_rule.json added to ~/.config/karabiner/assets/complex_modifications/"
else
  echo "\033[33m🚧WARNING:\033[0m karabiner_fake_vim_rule.json already exists in ~/.config/karabiner/assets/complex_modifications/"
fi
