Answers to questions path, please run full script succesfully first to run those answers.

```{r}
# ---- Answers for q1..q5 ----
# Requires objects 'counts', 'dds', and 'res' created above

# q1: How many sequencing lanes were concatenated to form sample siRNA_ECC-1_NT_Rep1
# If you later generate a manifest upstream, read it here instead of hardcoding
sample_lanes <- c(ECC1_L1 = 4L, ECC1_L2 = 4L, H460_L1 = 4L, H460_L2 = 4L, ECC1_L1 = 4L, ECC1_L2 = 4L, PC-3_L1= 4L, PC-3_L2= 4L, PC_3_L1_siD= 4L, PC_3_L2_sid= 4L)
ans_q1 <- unname(sample_lanes["ym"])

# q2: What is the library size (total read counts) for siRNA_NCI-H460_NT_Rep1?
libsize <- colSums(counts)
ans_q2 <- unname(libsize["H460_L1"])+ unname(libsize["H460_L2"])

# q3: How many genes have nonzero counts in sample siRNA_PC-3_siDICER1_Rep1_L1?
ans_q3 <- sum(counts[, "ym"] > 0)

# q4: How many genes are upregulated \uc0\u8805 2-fold (log2FC \u8805  1) in siRNA_ECC-1_NT_Rep1 vs. siRNA_PC-3_siDICER1_Rep1_L1 with FDR < 0.01?
res_df <- as.data.frame(res)
ans_q4 <- sum(res_df$log2FoldChange >= 1 & res_df$padj < 0.01, na.rm = TRUE)

# q5: Which gene is ranked 4th by log2 fold change (most upregulated) in siRNA_ECC-1_NT_Rep1 vs. siRNA_PC-3_siDICER1_Rep1_L1?
res_df$SYMBOL <- rownames(res_df)
up_rank <- res_df %>%
  dplyr::filter(!is.na(log2FoldChange) & log2FoldChange > 0) %>%
  dplyr::arrange(dplyr::desc(log2FoldChange), padj, pvalue)
ans_q5 <- if (nrow(up_rank) >= 4) up_rank$SYMBOL[3] else NA_character_

answers <- tibble::tibble(
  id = c("q1","q2","q3","q4","q5"),
  answer = c(ans_q1, ans_q2, ans_q3, ans_q4, ans_q5)
)

answers
```
