{ pkgs, config, lib, ... }:
with lib;

{

    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withPython3 = true;

      plugins = with pkgs.vimPlugins;
        let
          vim-gruvbit = pkgs.vimUtils.buildVimPlugin {
            name = "vim-gruvbit";
            src = pkgs.fetchFromGitHub {
              owner = "habamax";
              repo = "vim-gruvbit";
              rev = "9c9336abbd08fbc2ddf9b4f60f6502dea37e3443";
              sha256 = "sha256-b2b55Fa4Pwq5nvp9aPCOpCgdoiIxALEjKkRoLfrt/64=";
            };
          };
        in [
          vimwiki
          vimagit
          vim-latex-live-preview
          vim-speeddating 
          vim-polyglot
          {
            plugin = vimsence;
            type = "viml";
            config = ''
              let g:vimsence_client_id = '439476230543245312'
              let g:vimsence_small_text = 'NeoVim'
              let g:vimsence_small_image = 'neovim'
              let g:vimsence_editing_details = 'Editing: {}'
              let g:vimsence_editing_state = 'Working on: {}'
              let g:vimsence_file_explorer_text = 'In NERDTree'
              let g:vimsence_file_explorer_details = 'Looking for files'
              "let g:vimsence_custom_icons = {'filetype': 'iconname'}
            '';
          }
  
          # UI & Themes
          vim-nerdtree-syntax-highlight
          nerdtree
          {
            plugin = gruvbox-material;
            type = "viml";
            config = ''
              " Available values: 'hard', 'medium'(default), 'soft'
            let g:gruvbox_material_background = 'hard'
            "let g:gruvbox_material_transparent_background = 1
            '';
          }
          {
            plugin = vim-gruvbit;
            type = "viml";
            config = ''
              func! s:gruvbit_setup() abort
                  hi Comment gui=italic cterm=italic
                  hi Statement gui=bold cterm=bold
              endfunc

              augroup colorscheme_change | au!
                  au ColorScheme gruvbit call s:gruvbit_setup()
              augroup END
            '';
          }
          {
            plugin = catppuccin-nvim;
            type = "lua";
            config = ''
              require("catppuccin").setup({
                flavor = "mocha",
                background = { dark = "mocha", },
                transparent_background = true,
           			color_overrides = {
				          mocha = {
					          base = "#181825",
					          mantle = "#181825",
					          crust = "#181825",
				          },
			          },
                term_colors = true,
              })
              vim.cmd.colorscheme "catppuccin"
            '';
          }
          #vim-airline
          lightline-vim
          colorizer
          #nvim-web-devicons
  
            # Language servers
          vim-nix
  
            # Code formatting
          neoformat
  
            # Quality of life
          #indentLine
          vim-illuminate
          # auto-pairs # or coc-pairs
          quick-scope
          /*{
            plugin = rainbow; #FIXME: broke nix syntax highlight
            type = "viml";
            config = ''
              let g:rainbow_active = 1
            '';
          }*/
          vim-orgmode
          telescope-nvim
          vim-clap
    
            # coc
          coc-clangd
          coc-python
          coc-prettier
          coc-pairs
        ];

      coc = {
        enable = true;
        pluginConfig = lib.strings.concatStringsSep "\n" [
            # use <tab> for trigger completion and navigate to the next complete item:
          ''
            function! CheckBackspace() abort
              let col = col('.') - 1
              return !col || getline('.')[col - 1]  =~# '\s'
            endfunction

            inoremap <silent><expr> <Tab>
              \ coc#pum#visible() ? coc#pum#next(1) :
              \ CheckBackspace() ? "\<Tab>" :
              \ coc#refresh()
          ''
            # Use <Tab> and <S-Tab> to naviguate the completion list:
          ''
            inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
            inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
          ''
        ];

          # https://github.com/neoclide/coc.nvim/blob/master/data/schema.json
          # ~/.config/nvim/coc-settings.json
        settings = {
          "suggest.noselect" = true;
          "suggest.enablePreview" = true;
          "suggest.enablePreselect" = false;
          "languageserver" = {
              # https://gitlab.com/jD91mZM2/nix-lsp
            "nix" = {
              "command" = "rnix-lsp";
              "filetypes" = [
                "nix"
              ];
            };
          };
        };
      };

      extraConfig = lib.strings.concatStringsSep "\n" [
        ''
          let mapleader =","
    
            " Disables automatic commenting on newline:
          autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
    
            " Perform dot commands over visual blocks:
          vnoremap . :normal .<CR>
    
            " Spell-check set to <leader>o:
          map <leader>oe :setlocal spell! spelllang=en_us<CR>
          map <leader>of :setlocal spell! spelllang=fr<CR>
    
            " Splits open at the bottom and right.
          set splitbelow splitright

            " split navigation:
    	    map <C-h> <C-w>h
    	    map <C-j> <C-w>j
    	    map <C-k> <C-w>k
    	    map <C-l> <C-w>l

          autocmd BufWritePost $XDG_CONFIG_HOME/x11/xresources silent exec "!xrdb $XDG_CONFIG_HOME/x11/xresources"
        ''
          # Plugins config
        ''
          map <leader>n :NERDTreeToggle<CR>
    	    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
          if has('nvim')
            let NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'
          else
            let NERDTreeBookmarksFile = '~/.vim' . '/NERDTreeBookmarks'
          endif
        ''
          # Custom Fontions
        ''    
            " Save file as sudo on files that require root permission
          command! W execute 'w !doas tee % > /dev/null' <bar> edit!
    
            " Check file in shellcheck:
    	    map <leader>s :!clear && shellcheck -x %<CR>
    
            " Compile document, be it groff/LaTeX/markdown/etc.
    	    map <leader>c :w! \| !compiler "<c-r>%"<CR>
    
            " Ensure files are read as what I want:
          let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
          map <leader>v :VimwikiIndex<CR>
          let g:vimwiki_list = [{'path': '~/.local/share/nvim/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
          autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
          autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
          autocmd BufRead,BufNewFile *.tex set filetype=tex
          autocmd BufRead,BufNewFile *.nix set filetype=nix



        ''
          # Visual
        ''
          "colorscheme gruvbox-material
          set title
          set termguicolors
          set background=dark
          set number relativenumber
          set noruler
          set wrap
          set showmatch
          set matchtime=3
          set noshowmode
          set noshowcmd
          filetype plugin on

          highlight Normal ctermbg=none guibg=NONE
          highlight NonText ctermbg=none guibg=NONE
          highlight LineNr ctermbg=none guibg=NONE
          highlight Folded ctermbg=none guibg=NONE
          highlight EndOfBuffer ctermbg=none guibg=NONE
        ''
          # Grep
        ''
          set ignorecase
          set smartcase
          set wrapscan
          set hlsearch
          set incsearch
          set inccommand=split
        ''
            # Indent
        ''
          set smartindent
          set expandtab
          set tabstop=2
          set softtabstop=1
          set shiftwidth=4
        ''
          # Auto Complete
        ''    
          set completeopt=noinsert,menuone,noselect
          set wildmode=list:longest
          set infercase
          set wildmenu
        ''
          # Other
        ''    
          set mouse=a
          set clipboard+=unnamedplus
          set backspace=indent,eol,start
          set hidden
          set textwidth=300
          set encoding=utf-8
          set nobackup
          set nocompatible
        ''
      ];
    };
  
    home.packages = with pkgs; [ rnix-lsp ];
}
