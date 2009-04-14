if !exists('loaded_snippet') || &cp
    finish
endif

let st = g:snip_start_tag
let et = g:snip_end_tag
let cd = g:snip_elem_delim

exec "Snippet if <xsl:if test=\"".st.et."\"><CR>".st.et."<CR></xsl:if>".st.et
exec "Snippet choose <xsl:choose><CR>".st.et."<CR></xsl:choose>".st.et
exec "Snippet when <xsl:when test=\"".st.et."\"><CR>".st.et."<CR></xsl:when>".st.et
exec "Snippet other <xsl:otherwise><CR>".st.et."<CR></xsl:otherwise>".st.et

exec "Snippet call <xsl:call-template name=\"".st.et."\"><CR>".st.et."<CR></xsl:call-template>".st.et
exec "Snippet ct <xsl:call-template name=\"".st.et."\"/>".st.et

exec "Snippet param <xsl:param name=\"".st.et."\" select=\"".st.et."\"/>".st.et
exec "Snippet wp <xsl:with-param name=\"".st.et."\" select=\"".st.et."\"/>".st.et

exec "Snippet var <xsl:variable name=\"".st.et."\" select=\"".st.et."\"/>".st.et

exec "Snippet vo <xsl:value-of select=\"".st.et."\"/>".st.et

